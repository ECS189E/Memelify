"""Error Handlers"""
from flask import Blueprint
from flask import jsonify
from werkzeug.http import HTTP_STATUS_CODES

blueprint = Blueprint('errors', __name__)


@blueprint.app_errorhandler(404)
def not_found_error(error):
    return error_response(404, 'We only support `/api/memes/latest` and `/api/memes/hot` .')


@blueprint.app_errorhandler(500)
def internal_error(error):
    return error_response(500)


def error_response(status_code, message=None):
    payload = {
        'error': HTTP_STATUS_CODES.get(status_code, 'Unknown error'),
        'code': status_code,}
    if message:
        payload['message'] = message
    response = jsonify(payload)
    response.status_code = status_code
    return response
