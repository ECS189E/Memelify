"""
Handle all Meme requests
"""
import datetime
from datetime import date
from sqlalchemy import Date, cast

from flask import Blueprint, request, jsonify
from memelify.meme.models import RedditMeme

blueprint = Blueprint('meme',  __name__)


@blueprint.route('memes/latest', methods=('GET', ))
def query_latest_memes():
    offset = request.args.get('offset', default=0, type=int)
    limit = request.args.get('limit', default=10, type=int)
    latest_memes = (RedditMeme.query
                    .filter(RedditMeme.funny_score > 0.2)  # 20% Threshold
                    .order_by(RedditMeme.created_utc.desc())
                    .offset(offset)
                    .limit(limit)
                    .all())
    return jsonify(memes=[meme.serialize for meme in latest_memes])


@blueprint.route('memes/hot', methods=('GET', ))
def query_hottest_memes():
    offset = request.args.get('offset', default=0, type=int)
    limit = request.args.get('limit', default=10, type=int)
    hottest_memes = (RedditMeme.query
                     .filter(RedditMeme.funny_score > 0.2)  # 20% Threshold
                     .order_by(RedditMeme.hotness.desc())
                     .offset(offset)
                     .limit(limit)
                     .all())
    return jsonify(memes=[meme.serialize for meme in hottest_memes])


@blueprint.route('memes/top', methods=('GET', ))
def get_top_meme():
    since_date = date.today() - datetime.timedelta(7)
    top_meme = (RedditMeme.query
                .filter(cast(RedditMeme.created_utc, Date) < since_date)
                # .filter(RedditMeme.funny_score > 0.2)  # 20% Threshold
                .order_by(RedditMeme.hotness.desc())
                .first())    
    return jsonify(top_meme.serialize if top_meme else {})
