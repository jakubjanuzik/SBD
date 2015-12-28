import psycopg2
from flask import request, g
from app import app
from psycopg2.extras import NamedTupleCursor
from flask import render_template, session, send_file
from app.decorators import login_required
from app.utils import get_user_by_id
import os.path


@app.before_request
def connect_to_db():
    g.db = psycopg2.connect(
        dbname=app.config['DATABASE_CREDENTIALS']['dbname'],
        user=app.config['DATABASE_CREDENTIALS']['user'],
        cursor_factory=NamedTupleCursor
    )


@app.before_request
def load_user():
    user_id = session.get('user')
    if user_id:
        user = get_user_by_id(user_id)
    else:
        user = None  # Make it better, use an anonymous User instead

    g.user = user


@app.teardown_request
def disconnect_from_db(exception):
    db = getattr(g, 'db', None)
    if db is not None:
        db.close()


@app.route('/', methods=['GET', 'POST'])
@login_required
def index():
    if request.method == 'POST':
        return 'Hello POST'
    return render_template('index.html')


@app.route('/image/<path>', methods=['GET'])
@login_required
def image(path):
    return send_file(os.path.join('media/images', path))
