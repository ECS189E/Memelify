"""Meme Classifer Factory.

A meme classifer is a binary image classification mmodel. It predicts whether a
given imageis meme or not.
"""
import os
import numpy as np
import tensorflow as tf

from PIL import Image
from urllib.request import urlopen
import skimage
from skimage.color import rgba2rgb, gray2rgb

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
    # from memory_profiler import profile
    # @profile
    def get_meme_score(img_url):
        # Load and preprocess image
        bstring = urlopen(img_url)
        img = Image.open(bstring)
        img = img.resize((224, 224), Image.AFFINE)
        img = np.array(img)
        if len(img.shape) > 2 and img.shape[2] == 4:
            img = rgba2rgb(img)
        elif img.size == 2:
            img = gray2rgb(img)
        img = np.expand_dims(preprocess_fn(img.astype(np.float32)), 0)

        # Predict meme score
        model.set_tensor(input_details[0]['index'], img)
        model.invoke()
        score = model.get_tensor(output_details[0]['index'])
        return float(score.ravel()[0])  # meme:0 not_meme: 1
    return get_meme_score


if __name__ == "__main__":  # Test
    MEME_URL = ['https://i.redd.it/rynj92e216021.jpg',
                'https://i.redd.it/y0d9p1hybm121.jpg',
                'https://i.redd.it/eyy0w1gppc121.jpg',
                'https://i.redd.it/5err4vherp021.jpg']
    classifier = create_classifier()
    for url in MEME_URL:
        score = classifier(url)
        print(score)
    # converter = tf.contrib.lite.TFLiteConverter.from_saved_model(_MODEL_PATH)
    # converter.post_training_quantize = True
    # open("converted_model.tflite", "wb").write(converter.convert())
