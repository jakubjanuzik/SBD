from flask import render_template, flash, redirect, url_for
from app.decorators import login_required
from app.utils import run_custom_query, select_all_from_table

from . import clients
from .forms import UserForm
from .models import (
    create_client, get_client, edit_client, get_full_client_dict
)


@login_required
@clients.route('/create/', methods=['GET', 'POST'])
def create():
    form = UserForm()
    if form.validate_on_submit():
        create_client(form)
    return render_template('clients/create.html', form=form)


@login_required
@clients.route('/edit/<int:client_id>', methods=['GET', 'POST'])
def edit(client_id):
    client = get_client(client_id)
    form = UserForm(obj=client)
    if form.validate_on_submit():
        form.populate_obj(client)
        edit_client(form, client_id)
        redirect(url_for('clients.list'))
    return render_template('clients/create.html', form=form)


@login_required
@clients.route('/', methods=['GET'])
def list():
    clients = select_all_from_table('clients')
    clients_list = []
    for client in clients:
        clients_list.append(get_full_client_dict(client))

    return render_template(
        'clients/list.html',
        clients=sorted(clients_list, key=lambda x: x['id'])
    )


@login_required
@clients.route('/delete/<int:client_id>', methods=['GET'])
def delete(client_id):
    try:
        run_custom_query(
            """DELETE FROM CLIENT_PHONES WHERE client_id = {}""".format(
                client_id
            ),
            fetch=False
        )
        run_custom_query(
            """DELETE FROM CLIENTS WHERE ID = {}""".format(client_id),
            fetch=False
        )
        return redirect(url_for('clients.list'))
    except:
        flash('Something went wrong. Please, contact administrator', 'error')
        return redirect(url_for('clients.list'))
