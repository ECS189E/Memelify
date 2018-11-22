"""Memelify's Reddit Bot listens on /r/UCDavis for potential new memes. Whenever
 it found a new meme, it will:
    * Download post meta data (title,  image_url) to our server.
    * Create an `INSERT` query the meta data into PostgreSQL.
    * Track number of upvotes/downvotes to update the metadata.

## TODO:
-------
* Make it work
"""
import praw
from datetime import datetime
from urllib.parse import urlparse

# A set of supported meme extensions
SUPPORTED_EXTENSION = {'jpeg', 'jpg', 'gif', 'png'}


class RedditMemeBot:
    """Find all meme posts in a given subreddit"""
    def __init__(self, subreddit_name, client_id, client_secret):
        self.bot = create_bot(subreddit_name, client_id, client_secret)
        self.latest = [p for p in self.bot.new(limit=None) if is_meme(p)]
        self.hottest = [p for p in self.bot.hot(limit=None) if is_meme(p)]

    def get_latest_memes(self, offset=0, limit=10):
        """Return list of latest memes in current subreddit"""
        limit = min(limit, len(self.latest) - offset)
        has_more = True if offset + limit < len(self.latest) else False

        latest_memes = [meme2dict(p) for p in self.latest[offset:offset+limit]]
        return has_more, latest_memes

    def get_hottest_memes(self, offset=0, limit=10):
        """Returns list of hottest memes in current subreddit"""
        limit = min(limit, len(self.hottest) - offset)
        has_more = True if offset + limit < len(self.hottest) else False

        hottest_memes = [meme2dict(p) for p in self.hottest[offset:offset+limit]]
        return has_more, hottest_memes


def create_bot(name, client_id, client_secret):
    """Create a subreddit bot instance"""
    return praw.Reddit(client_id=client_id, 
                        client_secret=client_secret,
                        user_agent='%s Bot'%name).subreddit(name)


def is_meme(submission):
    """Determine if a submission on Reddit is a meme."""
    if not submission.url: return False
    url_extension = urlparse(submission.url).path.split('.')[-1]
    # TODO: if we have time, we can also build meme binary classifier.
    return True if url_extension in SUPPORTED_EXTENSION else False


def meme2dict(meme):
    """Convert a meme to dictionary object to parse into json easier"""
    meme_dict = {
        'id': meme.id,
        'title': meme.title,
        'likes': meme.score,
        'url': meme.url,
        'created': str(datetime.fromtimestamp(meme.created_utc)),
    }
    return meme_dict