import psycopg2
from flask import request, g
from app import app

from flask import render_template


@app.before_request
def connect_to_db():
    g.db = psycopg2.connect(
        dbname=app.config['DATABASE_CREDENTIALS']['dbname'],
        user=app.config['DATABASE_CREDENTIALS']['user']
    )


@app.teardown_request
def disconnect_from_db(exception):
    db = getattr(g, 'db', None)
    if db is not None:
        db.close()


@app.route('/', methods=['GET', 'POST'])
def hello():
    if request.method == 'POST':
        return 'Hello POST'
    return render_template('index.html')
