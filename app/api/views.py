from flask import jsonify
from . import api


@api.route('/', methods=['GET'])
def hello():
    return jsonify({
        'error': False,
        'result': []
    })
