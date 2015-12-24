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
    # For testing purposes :-) Example usage

    # values = {'id': 6, 'name': 'qwert'}
    # utils.insert_into_table(tablename, values)
    # data = utils.select_all_from_table(tablename)

    data = utils.select_fields_from_table_by_ids(
        tablename=tablename,
        fields=['id', 'name'],
        ids_list=[2, 3, 4]
    )

    return jsonify({
        'error': False,
        'result': data
    })
