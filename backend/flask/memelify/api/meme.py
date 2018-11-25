"""Handle all Meme requests"""
from .models import Meme
from flask import Blueprint, request

meme_blueprint = Blueprint('meme', 
                           __name__)

@meme_blueprint.route('/api/memes/latest', methods=('GET', ))
def get_latest_feed():
    """Query latest memes from PosgreSQL database"""
    offset = request.args.get('offset', default=0, type=int)
    limit  = request.args.get('limit', default=10, type=int)
    latest_memes = (Meme.query.order_by(Meme.created_at)
                        .offset(offset)
                        .limit(limit)
                        .all())
    return latest_memes


@meme_blueprint.route('/api/memes/hot', methods=('GET', ))
def get_hottest_feed():
    """Return hottest memes"""
    offset = request.args.get('offset', default=0, type=int)
    limit  = request.args.get('limit', default=10, type=int)
    hot_memes = (Meme.query.order_by(Meme.hotness)
                     .offset(offset)
                     .limit(limit)
                     .all())
    return hot_memes


@blueprint.route('/api/memes/refresh', methods=('POST', ))
def refresh():
    """Ask Reddit Meme bot to load latest meme"""



# has_more, memes = bot.get_latest_memes(offset, limit)
# return jsonify(has_more=has_more,
#                offset=offset,
#                size=len(bot.latest), 
#                memes=memes)
# has_more, memes = bot.get_hottest_memes(offset, limit)
# return jsonify(has_more=has_more,
#                offset=offset,
#                size=len(bot.hottest), 
#                memes=memes)