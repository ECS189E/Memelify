"""Meme Classifer Factory.

A meme classifer is a binary image classification mmodel. It predicts whether a
given imageis meme or not.
"""
import os
import numpy as np
import tensorflow as tf
import skimage as skimg

_BASE_DIR = os.path.abspath(os.path.dirname(__file__))
_MODEL_PATH = os.path.join(_BASE_DIR, 'model.tflite')

# Transforms image (normalization) before placing into classifier
_PROCESS_FN = tf.keras.applications.mobilenet_v2.preprocess_input


def create_classifier(model_path=_MODEL_PATH, preprocess_fn=_PROCESS_FN):
    """Construct a TensorFlow model for inference. 

    Arguments:
        model_path: str - path to trained classifer model (tf.SavedModel)
        preprocess_fn: callable func - preprocess image method for inference

    Returns:
        get_meme_score: - a callable func
    """
    # Load TFLite model and allocate tensors.
    model = tf.contrib.lite.Interpreter(model_path)
    model.allocate_tensors()

    # Get input and output tensors.
    input_details = model.get_input_details()
    output_details = model.get_output_details()

    def get_meme_score(img_url):
        # Load and preprocess image
        img = skimg.io.imread(img_url)
        img = skimg.transform.resize(img, (224, 224), preserve_range=True)
        if len(img.shape) > 2 and img.shape[2] == 4:
            img = skimg.color.rgba2rgb(img)
        else:
            img = skimg.color.gray2rgb(img)
        img = preprocess_fn(img.astype(np.float32))
        img = np.expand_dims(img, 0)

        # Predict meme score
        model.set_tensor(input_details[0]['index'], img)
        model.invoke()
        score = model.get_tensor(output_details[0]['index'])
        return score.ravel()[0]  # meme:0 not_meme: 1
    return get_meme_score


if __name__ == "__main__":  # Test
    MEME_URL = 'https://i.redd.it/rynj92e216021.jpg'
    get_meme_score_fn = create_classifier()
    score = get_meme_score_fn(MEME_URL)
    print(score)
    # converter = tf.contrib.lite.TFLiteConverter.from_saved_model(_MODEL_PATH)
    # converter.post_training_quantize = True
    # open("converted_model.tflite", "wb").write(converter.convert())
