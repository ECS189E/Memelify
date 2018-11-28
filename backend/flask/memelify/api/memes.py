"""Meme Request Handlers"""
from flask import Blueprint, jsonify, request
from memelify.bots import RedditMemeBot

blueprint = Blueprint('memes',  __name__)
bot = RedditMemeBot('UCDavis', 
                    'ClShg45mn9UHxw', 
                    'h9TDXwNUT3X5xUUVI3WgIficOKA')


@blueprint.route('memes/latest', methods=('GET', ))
def get_latest_feed():
    """Query latest memes"""
    offset = request.args.get('offset', default=0, type=int)
    limit  = request.args.get('limit', default=10, type=int)
    has_more, memes = bot.get_latest_memes(offset, limit)
    meta = {
        "has_more": has_more,
        "offset": offset,
        "size":len(bot.latest),   
        "last_updated":bot.last_updated 
    }
    return jsonify(_meta=meta, memes=memes)


@blueprint.route('memes/hot', methods=('GET', ))
def get_hottest_feed():
    """Return hottest memes"""
    offset = request.args.get('offset', default=0, type=int)
    limit  = request.args.get('limit', default=10, type=int)
    has_more, memes = bot.get_hottest_memes(offset, limit)
    meta = {
        "has_more": has_more,
        "offset": offset,
        "size":len(bot.hottest),   
        "last_updated":bot.last_updated 
    }
    return jsonify(_meta=meta, memes=memes)


@blueprint.route('memes/refresh', methods=('POST', ))
def refresh():
    """Ask Reddit Meme bot to load latest meme"""
    return jsonify(status='refersh')