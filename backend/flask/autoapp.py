"""
Create a Memelify Service instance.
"""
from flask.helpers import get_debug_flag
from memelify import create_app, config

CONFIG = config.DevConfig if get_debug_flag() else config.ProdConfig
app = create_app(CONFIG)