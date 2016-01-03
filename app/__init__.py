from flask import Flask


app = Flask(__name__)

from . import views

from .users import users
from .product import product
from .clients import clients

app.register_blueprint(users)
app.register_blueprint(product)
app.register_blueprint(clients)
