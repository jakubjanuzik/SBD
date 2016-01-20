from flask import Flask


app = Flask(__name__)

from . import views

from .users import users
from .product import product
from .clients import clients
from .orders import orders
from .statuses import statuses

app.register_blueprint(users)
app.register_blueprint(product)
app.register_blueprint(clients)
app.register_blueprint(orders)
app.register_blueprint(statuses)
