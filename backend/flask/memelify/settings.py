# -*- coding: utf-8 -*-
"""Application configuration."""
import os
from memelify.tasks import get_memes

class Config(object):
    JOBS = [
        {
            'id': 'update-memes-every-20-secs',
            'func': get_memes,
            'trigger': 'interval',
            'seconds': 30,
        }
    ]
    SCHEDULER_JOB_DEFAULTS = {'coalesce': False,  'max_instances': 1 }
    SCHEDULER_API_ENABLED = True


class DevConfig(Config):
    """Development configuration."""
    ENV = 'dev'
    DEBUG = True
    TESTING = False
    SECRET_KEY = "please_let_my_cookies_live_while_developing"


class ProdConfig(Config):
    """Production configuration."""
    ENV = 'prod'
    DEBUG = False
    SECRET_KEY = None  # To be overwritten by a YAML file