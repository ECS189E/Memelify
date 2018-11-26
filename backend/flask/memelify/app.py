"""Holds the create_app() Flask application factory."""
import os
from flask import Flask


def create_app(config_object):
    """Flask application factory. Initializes and returns the Flask application.
    http://flask.pocoo.org/docs/patterns/appfactories/.
    """ 
    app = Flask(__name__)
    app.url_map.strict_slashes = False   # allows both '/api' and '/api/'
    app.config.from_object(config_object)

    register_blueprints(app)
    register_extensions(app)
    return app


def register_blueprints(app):
    """Register Flask blueprints."""

    from memelify.api import memes
    app.register_blueprint(memes.blueprint, url_prefix='/api')
    
    from memelify.api import errors
    app.register_blueprint(errors.blueprint)


def register_extensions(app):
    """Register Flask extensions."""

    from flask_apscheduler import APScheduler
    scheduler = APScheduler()
    scheduler.init_app(app)  # jobs are defined under app.config
    scheduler.start()
