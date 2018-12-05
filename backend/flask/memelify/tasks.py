"""
List of background tasks while running the app
"""
from flask import current_app
from datetime import datetime as dt
from memelify import create_app_context

from memelify.extensions import rq, db
from memelify.meme.models import RedditMeme
from memelify.bots import create_bot, create_classifier, is_image

reddit_bot = create_bot()
meme_predictor = None

@rq.job
def find_reddit_memes(limit=None):
    """Find new memes"""
    global meme_predictor
    with current_app.app_context():
        if meme_predictor is None:
            meme_predictor = create_classifier()
        new_posts = reddit_bot.new(limit=limit)
        for post in new_posts:
            if is_image(post):
                exists = (db.session.query(RedditMeme.id)
                            .filter_by(id=post.id)
                            .scalar() is not None)
                if not exists:
                    post.funny_score = meme_predictor(post.url)
                    RedditMeme.create(post)


@rq.job
def update_hot_score():
    with current_app.app_context():
        print("Updating hotness score")
        memes = db.session.query(RedditMeme).all()
        for m in memes:
            m.set_hotness()


# Cron jobs are scheduled tasks to be executed every certain time.
print("Setting up cron jobs")
find_reddit_memes.cron('* * * * *', 'find_memes', limit=5, queue='low')  # every 1 minute
update_hot_score.cron('* * * * *', 'update_memes', queue='high')          # every 2 minutes
