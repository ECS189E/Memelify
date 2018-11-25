
from flask import Flask
from memelify.database import db

def create_app(config_object):
    """Folllow Flask App Factory Pattern
    http://flask.pocoo.org/docs/patterns/appfactories/.

    """ 
    app = Flask(__name__)
    app.url_map.strict_slashes = False   # allows both '/api' and '/api/'
    app.config.from_object(config_object)

    register_extensions(app)
    register_blueprints(app)
    return app


def register_extensions(app):
    """Register Flask extensions."""
    db.init_app(app)
    db.relfect(app=app)
    return app


def register_blueprints(app):
    """Register Flask blueprints."""
    origins = app.config.get('CORS_ORIGIN_WHITELIST', '*')
    cors.init_app(user.views.blueprint, origins=origins)
    cors.init_app(profile.views.blueprint, origins=origins)
    cors.init_app(articles.views.blueprint, origins=origins)

    app.register_blueprint(user.views.blueprint)
    app.register_blueprint(profile.views.blueprint)
    app.register_blueprint(articles.views.blueprint)


# from meme_bot.reddit import RedditMemeBot
# bot = RedditMemeBot('UCDavis', 'ClShg45mn9UHxw', 'h9TDXwNUT3X5xUUVI3WgIficOKA')
