"""
Handle all Meme requests
"""
from flask import Blueprint, request, jsonify
from memelify.meme.models import RedditMeme
blueprint = Blueprint('meme',  __name__)


@blueprint.route('memes/latest', methods=('GET', ))
def query_latest_memes():
    offset = request.args.get('offset', default=0, type=int)
    limit = request.args.get('limit', default=10, type=int)
    latest_memes = (RedditMeme.query.order_by(RedditMeme.created_utc)
                    .offset(offset)
                    .limit(limit)
                    .all())
    return jsonify(memes=[meme.serialize for meme in latest_memes])


@blueprint.route('memes/hot', methods=('GET', ))
def query_hottest_memes():
    offset = request.args.get('offset', default=0, type=int)
    limit = request.args.get('limit', default=10, type=int)
    hottest_memes = (RedditMeme.query.order_by(RedditMeme.hotness.desc())
                     .offset(offset)
                     .limit(limit)
                     .all())
    return jsonify(memes=[meme.serialize for meme in hottest_memes])
