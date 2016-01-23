from flask import Blueprint

statuses = Blueprint('statuses', __name__, url_prefix='/status')

from . import views
