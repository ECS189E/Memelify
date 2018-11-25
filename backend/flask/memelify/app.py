from flask import Flask


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
    from memelify.database import db
    db.init_app(app)
    db.reflect(app=app)

    from memelify.extensions import Admin, ModelView
    from memelify.models import Meme

    admin = Admin(app, name='memelify', template_mode='bootstrap3')
    admin.add_view(ModelView(Meme, db.session))
    return app


def register_blueprints(app):
    """Register Flask blueprints."""
    from memelify.api.meme import meme_blueprint
    app.register_blueprint(meme_blueprint)


# from meme_bot.reddit import RedditMemeBot
# bot = RedditMemeBot('UCDavis', 'ClShg45mn9UHxw', 'h9TDXwNUT3X5xUUVI3WgIficOKA')
