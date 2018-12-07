"""
Handle all Meme requests
"""
import datetime
from datetime import date
from sqlalchemy import Date, cast, and_

from flask import Blueprint, request, jsonify
from memelify.meme.models import RedditMeme

blueprint = Blueprint('meme',  __name__)

_FUNNY_SCORE_THRESHOLD = 0.2
_ENABLE_NOFITICATION = False

@blueprint.route('memes/latest', methods=('GET', ))
def query_latest_memes():
    offset = request.args.get('offset', default=0, type=int)
    limit = request.args.get('limit', default=10, type=int)
    latest_memes = (RedditMeme.query
                    .filter(and_(
                        RedditMeme.funny_score > _FUNNY_SCORE_THRESHOLD,
                        RedditMeme.is_hidden is not True))
                    .order_by(RedditMeme.created_utc.desc())
                    .offset(offset)
                    .limit(limit)
                    .all())
    return jsonify(memes=[meme.serialize for meme in latest_memes])


@blueprint.route('memes/<meme_id>', methods=('GET', ))
def query_a_meme(meme_id):
    meme = RedditMeme.query.filter_by(id=meme_id).first()
    json = meme.serialize if meme else {}
    return jsonify(json)


@blueprint.route('memes/hot', methods=('GET', ))
def query_hottest_memes():
    offset = request.args.get('offset', default=0, type=int)
    limit = request.args.get('limit', default=10, type=int)
    hottest_memes = (RedditMeme.query
                     .filter(and_(
                        RedditMeme.funny_score > _FUNNY_SCORE_THRESHOLD,
                        RedditMeme.is_hidden is not True))
                     .order_by(RedditMeme.hotness.desc())
                     .offset(offset)
                     .limit(limit)
                     .all())
    return jsonify(memes=[meme.serialize for meme in hottest_memes])


@blueprint.route('memes/top', methods=('GET', ))
def get_top_meme():
    global _ENABLE_NOFITICATION

    since_date = date.today() - datetime.timedelta(2)
    top_meme = (RedditMeme.query
                .filter(and_(
                    cast(RedditMeme.created_utc, Date) < since_date),
                    RedditMeme.funny_score > _FUNNY_SCORE_THRESHOLD,
                    RedditMeme.is_hidden is not True,
                )
                .order_by(RedditMeme.hotness.desc())
                .first())

    print(_ENABLE_NOFITICATION)
    if _ENABLE_NOFITICATION is True:
        return jsonify(top_meme.serialize if top_meme else {})
    else:
        return jsonify({})


@blueprint.route('memes/notification', methods=('GET', ))
def notify():
    global _ENABLE_NOFITICATION

    enable = request.args.get('enable', default=0, type=int)
    _ENABLE_NOFITICATION = bool(enable)
    return jsonify(enable=_ENABLE_NOFITICATION)
