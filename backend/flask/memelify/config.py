# -*- coding: utf-8 -*-
"""Application configuration."""
import os
from memelify.tasks import wait_task

class Config(object):
    JOBS = [
        {
            'id': 'test-update-date',
            'func': wait_task,
            'trigger': 'interval',
            'seconds': 10,
        }
    ]
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