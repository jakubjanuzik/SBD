from app import app

from flask import request, render_template


@app.route('/', methods=['GET'])
def hello():
    if request.method == 'POST':
        return 'Hello POST'
    return render_template('index.html')
