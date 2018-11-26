# -*- coding: utf-8 -*-
"""Application configuration."""
import os


class Config(object):
    """Base configuration."""
    CACHE_TYPE = 'simple'  # Can be "memcached", "redis".


class DevConfig(Config):
    """Development configuration."""
    ENV = 'dev'
    DEBUG = True

class ProdConfig(Config):
    """Production configuration."""
    ENV = 'prod'
    DEBUG = False