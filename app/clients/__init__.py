from flask import Blueprint

clients = Blueprint('clients', __name__, url_prefix='/clients')

from . import views