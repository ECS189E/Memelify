"""Handle all Meme requests"""
from .model import Meme
from flask import Blueprint, request

meme_blueprint = Blueprint('meme', __name__)

@meme_blueprint.route('/api/memes/latest', methods=('GET', ))
def get_meme_latest_feed():
    """Query latest memes from PosgreSQL database

    Arguments:
        
    Returns:
        JSON object: all memes data
    """
    offset = request.args.get('offset', default=0, type=int)
    limit  = request.args.get('limit', default=10, type=int)
    has_more, memes = bot.get_latest_memes(offset, limit)
    return jsonify(has_more=has_more,
                   offset=offset,
                   size=len(bot.latest), 
                   memes=memes)


@meme_blueprint.route('/api/memes/hot', methods=('GET', ))
def get_meme_hottest_feed():
    """Return hottest memes"""
    offset = request.args.get('offset', default=0, type=int)
    limit  = request.args.get('limit', default=10, type=int)
    has_more, memes = bot.get_hottest_memes(offset, limit)
    return jsonify(has_more=has_more,
                   offset=offset,
                   size=len(bot.hottest), 
                   memes=memes)


@meme_blueprint.route('/api/memes/refresh', methods=('POST', ))
def refresh():
    """Ask Reddit Meme bot to load latest meme"""