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
from urllib.parse import urlparse

# List of all supported meme extension
SUPPORTED_EXTENSION = {'jpeg', 'jpg', 'gif', 'png'}


def subreddit_bot(name='UCDavis'):
    """Create a subreddit bot instance"""
    # TODO: hide client id and client secret
    reddit = praw.Reddit(client_id='ClShg45mn9UHxw', 
                         client_secret='h9TDXwNUT3X5xUUVI3WgIficOKA',
                         user_agent='UC Davis Bot')
    return reddit.subreddit(name)


def has_meme(post):
    """Determine if a post has an image URL (potential meme)"""
    if not post.url: return False
    url_extension = urlparse(post.url).path.split('.')[-1]
    return True if url_extension in SUPPORTED_EXTENSION else False


if __name__ == "__main__":
    bot = subreddit_bot(name='UCDavis')
    for p in bot.hot():
        if has_meme(p):
            print(p.id, p.score, p.title, p.url)       