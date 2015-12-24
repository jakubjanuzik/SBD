from flask import jsonify
from . import api
from app import utils


@api.route('/', methods=['GET'])
def hello():
    return jsonify({
        'error': False,
        'result': []
    })


@api.route('/all/<string:tablename>', methods=['GET'])
def get_all_from_table(tablename):
    data = utils.select_all_from_table(tablename)
    return jsonify({
        'error': False,
        'result': data
    })
