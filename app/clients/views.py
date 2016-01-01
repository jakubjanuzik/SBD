from flask import render_template
from . import clients
from .forms import UserForm
from app.decorators import login_required
from app.utils import run_custom_query


@login_required
@clients.route('/create/', methods=['GET', 'POST'])
def create():
    form = UserForm()
    if form.validate_on_submit():
        pass
    return render_template('clients/create.html', form=form)


@login_required
@clients.route('/', methods=['GET'])
def list():
    return render_template('clients/list.html')
