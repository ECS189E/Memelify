""" Meme model is loaded from existing posgreSQL database"""
from sqlalchemy import Table
from memelify.database import engine, metadata

RedditMeme = Table('RedditMeme', metadata, autoload=True)
