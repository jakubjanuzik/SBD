from . import statuses
from .forms import StatusForm
from .models import (
    create_status, update_status, delete_status, Status,get_all_statuses
)

from psycopg2 import IntegrityError
from flask import render_template, redirect, url_for


@statuses.route('/create', methods=['GET', 'POST'])
def create():
    form = StatusForm()
    if form.validate_on_submit():
        try:
            create_status(form.data)
        except IntegrityError:
            form.status_name.errors = (
                'Status with given name already exists',
            )
        else:
            return redirect(url_for('statuses.list'))
    return render_template(
        'statuses/create.html',
        form=form
    )


@statuses.route('/edit/<int:status_id>', methods=['GET', 'POST'])
def edit(status_id):
    status = ''
    form = StatusForm(obj=status)
    if form.validate_on_submit():
        try:
            update_status(status_id, form.data)
        except IntegrityError:
            form.status_name.errors = (
                'Status with given name already exists',
            )
        else:
            return redirect(url_for('statuses.list'))

    return render_template(
        'statuses/create.html',
        form=form
    )



@statuses.route('/list')
def list():
    statuses = get_all_statuses()

    return render_template(
        'statuses/list.html', statuses=statuses
    )


@statuses.route('delete/<int:status_id>', methods=['GET', 'POST'])
def delete(status_id):
    delete_status(status_id)
    return redirect(url_for('statuses.list'))
