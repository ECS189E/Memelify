"""A Flask Microservice"""
import json
from meme_bot.reddit import RedditMemeBot
from flask import Flask, request, jsonify

app = Flask(__name__)
bot = RedditMemeBot('UCDavis', 'ClShg45mn9UHxw', 'h9TDXwNUT3X5xUUVI3WgIficOKA')

@app.route('/api/memes', methods=('GET',))
def get_memes():
    """Return all memes data"""
    return json.dumps(bot.get_latest_memes(0, limit=1000))


@app.route('/api/memes/latest', methods=('GET', ))
def meme_latest_feed():
    """Return latest memes"""
    offset = request.args.get('offset', default=0, type=int)
    limit  = request.args.get('limit', default=10, type=int)
    has_more, memes = bot.get_latest_memes(offset, limit)
    return jsonify(has_more=has_more,
                   offset=offset,
                   size=len(bot.latest), 
                   memes=memes)


@app.route('/api/memes/hot', methods=('GET', ))
def meme_hottest_feed():
    """Return hottest memes"""
    offset = request.args.get('offset', default=0, type=int)
    limit  = request.args.get('limit', default=10, type=int)
    has_more, memes = bot.get_hottest_memes(offset, limit)
    return jsonify(has_more=has_more,
                   offset=offset,
                   size=len(bot.hottest), 
                   memes=memes)


if __name__ == '__main__':
    app.run(debug=True)
