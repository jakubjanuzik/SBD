import psycopg2
from flask import request, g
from app import app
from psycopg2.extras import NamedTupleCursor
from flask import render_template, session
from users.models import get_user_by_id
from app.decorators import login_required


@app.before_request
def connect_to_db():
    g.db = psycopg2.connect(
        dbname=app.config['DATABASE_CREDENTIALS']['dbname'],
        user=app.config['DATABASE_CREDENTIALS']['user'],
        cursor_factory=NamedTupleCursor
    )


@app.before_request
def load_user():
    if 'user' in session:
        user = get_user_by_id(session['user'])
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
