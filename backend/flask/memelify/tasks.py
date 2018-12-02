"""
List of background tasks while running the app
"""
from datetime import datetime as dt
from memelify import create_app_context

from memelify.extensions import rq, db
from memelify.meme.models import RedditMeme
from memelify.bots import create_bot, create_classifier, is_image

reddit_bot = create_bot()
meme_predictor = create_classifier()


@rq.job
def update_reddit_memes(limit=None):
    """Find new memes"""
    app = create_app_context()
    app.app_context().push()
    new_posts = reddit_bot.new(limit=limit)
    for post in new_posts:
        if is_image(post):
            exists = (db.session.query(RedditMeme.id)
                        .filter_by(id=post.id)
                        .scalar() is not None)
            if not exists:
                post.funny_score = meme_predictor(post.url)
                RedditMeme.create(post)
