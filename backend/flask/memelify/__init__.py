"""
Holds the create_app() Flask application factory.
"""
from flask import Flask
from memelify.config import Config
from memelify.extensions import db, migrate, admin, rq


def create_app_context(config_object=Config):
    app = Flask(__name__)
    app.url_map.strict_slashes = False   # allows both '/api' and '/api/'
    app.config.from_object(config_object)
    register_extensions(app)
    return app


def create_app(config_object):
    """Flask application factory. Initializes and returns the Flask application.
    http://flask.pocoo.org/docs/patterns/appfactories/.
    """
    app = create_app_context(config_object)
    register_blueprints(app)

    @app.before_first_request
    def run_first_task():
        from memelify.tasks import update_reddit_memes
        update_reddit_memes.queue(limit=None, job_id="should-not-be-duplicated")
    return app


def register_blueprints(app):
    """Register Flask blueprints.

    We follow this `registration` pattern to avoid cyclic import issue.
    Ref: https://stackoverflow.com/questions/744373/
    """
    from memelify.meme.controllers import blueprint
    app.register_blueprint(blueprint, url_prefix='/api')

    import rq_dashboard
    app.config.from_object(rq_dashboard.default_settings)
    app.register_blueprint(rq_dashboard.blueprint, url_prefix='/rq')


def register_extensions(app):
    """Register Flask extensions."""

    # Connecting App to database
    db.init_app(app)
    migrate.init_app(app, db)

    # Create a Admin page for managing database
    admin.init_app(app)
    from memelify.extensions import MemeViewer
    from memelify.meme.models import RedditMeme
    admin.add_view(MemeViewer(RedditMeme, db.session))

    # Create a Redis Queue for handling background tasks
    rq.init_app(app)
