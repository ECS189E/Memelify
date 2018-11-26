from flask import Flask
from memelify import config

def create_app(config_object):
    """Folllow Flask App Factory Pattern
    http://flask.pocoo.org/docs/patterns/appfactories/.
    """ 
    app = Flask(__name__)
    app.url_map.strict_slashes = False   # allows both '/api' and '/api/'
    app.config.from_object(config_object)
    register_blueprints(app)
    return app


def register_blueprints(app):
    """Register Flask blueprints."""
    from memelify.api import memes, errors
    app.register_blueprint(memes.blueprint, url_prefix='/api')
    app.register_blueprint(errors.blueprint)