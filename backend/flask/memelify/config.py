"""Application configuration."""
import os
basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    # To avoid Flask to sort json objects
    JSON_SORT_KEYS = False
    SECRET_KEY = os.environ.get('SECRET_KEY', 'cookies_live_while_developing')
    RQ_REDIS_URL = os.getenv('REDISTOGO_URL', 'redis://localhost:6379')

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'sqlite:///' +
                                        os.path.join(basedir, 'app.db'))
