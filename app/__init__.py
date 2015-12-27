from flask import Flask


app = Flask(__name__)

from . import views

from .api import api
from .users import users

app.register_blueprint(api)
app.register_blueprint(users)
