"""Extensions for Memelify"""
from flask_rq2 import RQ
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy

from jinja2 import Markup
from flask_admin import Admin, form
from flask_admin.contrib.sqla import ModelView

rq = RQ()
db = SQLAlchemy()
migrate = Migrate()
admin = Admin(template_mode='bootstrap3')


class MemeViewer(ModelView):
    """Allow Flask-Admin to display meme from an URL"""
    column_list = ('funny_score', 'votes', 'hotness', 'created_utc', 'updated', 'url')

    def _display_meme(self, context, model, name):
        if not model.url:
            return ''
        return Markup(
            '</figure>\
                <a href="{url}" style="font-size:70%;">\
                    <img src="{url}" height="100px" width="auto">\
                </a>\
                <p>{title}</p>\
            </figure>'.format(url=model.url, title=model.title))

    column_formatters = {
        'url': _display_meme
    }
