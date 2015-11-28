from app import app

from flask import request


@app.route('/', methods=['GET'])
def hello():
    if request.method == 'POST':
        return 'Hello POST'
    return 'Hello'
