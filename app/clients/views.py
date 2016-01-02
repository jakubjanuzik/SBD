from flask import render_template
from . import clients
from .forms import UserForm
from app.decorators import login_required
from .models import create_client, get_client


@login_required
@clients.route('/create/', methods=['GET', 'POST'])
def create():
    form = UserForm()
    if form.validate_on_submit():
        create_client(form)
    return render_template('clients/create.html', form=form)


@login_required
@clients.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit(id):
    client = get_client(id)
    form = UserForm(obj=client)
    if form.validate_on_submit():
        create_client(form)
    return render_template('clients/create.html', form=form)


@login_required
@clients.route('/', methods=['GET'])
def list():
    return render_template('clients/list.html')
