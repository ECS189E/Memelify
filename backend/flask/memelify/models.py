""" Meme model is loaded from existing posgreSQL database"""
from memelify.database import db

class Meme(db.Model):
    __tablename__ =  db.Model.metadata.tables['Meme']
