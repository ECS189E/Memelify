"""A Reddit Bot that looks for memes."""
import os
import praw
from datetime import datetime
from urllib.parse import urlparse


def create_bot():
    """Create a new subreddit bot instance"""
    name = os.getenv('SUBREDDIT', 'ucdavis')
    client_id = os.getenv('REDDIT_CLIENT_ID', 'ClShg45mn9UHxw')
    client_secret = os.getenv('REDDIT_CLIENT_SECRET',
                              'h9TDXwNUT3X5xUUVI3WgIficOKA')
    return praw.Reddit(client_id=client_id,
                       client_secret=client_secret,
                       user_agent='%s Bot' % name).subreddit(name)


def is_image(submission):
    if not submission.url:
        return False
    url_extension = urlparse(submission.url).path.split('.')[-1]
    return True if url_extension in {'jpeg', 'jpg', 'png'} else False
