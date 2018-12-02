# coding: utf-8
import math
import datetime as dt
from memelify.extensions import db
from sqlalchemy import Column, String, Text, Integer, Float


class RedditMeme(db.Model):
    '''Holds meta-data for each meme-related post on Reddit being tracked.'''
    id = Column(String(10), primary_key=True)
    url = Column(String(255), unique=True, nullable=False)
    title = Column(Text)
    votes = Column(Integer, default=0)
    upvote_ratio = Column(Float)
    hotness = db.Column(db.Float(15, 6), default=0.00)
    funny_score = db.Column(db.Float(2, 1),default=0.00)
    updated = Column(db.DateTime, nullable=False, default=dt.datetime.utcnow)
    created_utc = Column(db.DateTime, nullable=False, default=dt.datetime.utcnow)

    @property
    def serialize(self):
        """Convert a meme to dictionary object to parse into JSON easier"""
        return {
            'id': self.id,
            'title': self.title,
            'likes': self.votes,
            'url': self.url,
            'created': str(self.created_utc),
            'funny_score': self.funny_score,
        }

    @classmethod
    def create(cls, p):
        obj = cls(id=p.id, url=p.url, title=p.title, votes=p.score,
                  upvote_ratio=p.upvote_ratio,
                  funny_score=p.funny_score,
                  created_utc=dt.datetime.fromtimestamp(p.created_utc))
        obj.set_hotness()
        db.session.add(obj)
        db.session.commit()

    def update(self, post, commit=True):
        self.votes = post.score
        self.upvote_ratio = post.upvote_ratio
        self.hotness = self.get_hotness()
        if hasattr(post, 'funny_score'):
            self.funny_score = post.funny_score
        db.session.add(self)
        if commit:
            db.session.commit()

    def get_age(self):
        """raw age of this post in seconds"""
        return (self.created_utc - dt.datetime(1970, 1, 1)).total_seconds()

    def get_hotness(self):
        """reddit hotness algorithm (votes/(age^1.5)) """
        # Max/abs are not needed in our case
        order = math.log(max(abs(self.votes), 1), 10)
        seconds = self.get_age() - 1134028003
        return round(order + seconds / 45000, 6)

    def set_hotness(self):
        self.hotness = self.get_hotness()
        db.session.commit()
