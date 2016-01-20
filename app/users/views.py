from . import users
from flask import render_template, request, session, url_for, redirect, flash
from .forms import LoginForm, UserForm
from psycopg2 import IntegrityError
import hashlib
from app.utils import (
        check_auth, insert, select_one_or_404, update, select, run_custom_query
    )


@users.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = check_auth(request.form['username'], request.form['password'])
        if user:
            session['user'] = user.id
            return redirect(url_for('index'))
        else:
            flash('Invalid login credentials', 'error')

    return render_template('users/login.html', form=form)


@users.route('/logout', methods=['GET'])
def logout():
    if session['user'] is not None:
        session['user'] = None
    return redirect(url_for('users.login'))


@users.route('/create', methods=['GET', 'POST'])
def create():
    form = UserForm()
    if form.validate_on_submit():
        try:
            m = hashlib.md5()
            password = form.data['password'].encode('utf-8')
            m.update(password)
            hashpass = m.hexdigest()
            insert('users', {'username': form.data['username'], 'password': hashpass})
        except IntegrityError:
            getattr(form, 'username').errors = (
                    'User with given name already exists.',
                )
    return render_template('users/create.html', form=form)


@users.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit(id):
    user = select_one_or_404('users', {'id': id})
    form = UserForm(obj=user)
    if form.validate_on_submit():
        try:
            data = {}
            if form.data['password'] != '' and form.data['confirm'] != '':
                m = hashlib.md5()
                password = form.data['password'].encode('utf-8')
                m.update(password)
                hashpass = m.hexdigest()
                data['password'] = hashpass

            if form.data['username'] != user.username:
                data['username'] = form.data['username']

            if data:
                update('users', {'id': id}, data)
        except IntegrityError as e:
            if 'username_unique' in e.pgerror:
                getattr(form, 'username').errors = (
                    'User with given name already exists.',
                )
            else:
                flash('Something went wrong, try again.', 'error')
    return render_template('users/create.html', form=form)


@users.route('/list/', methods=['GET'])
def list():
    query = request.args.get('query', '')
    if query is not None:
        users = run_custom_query("""
            SELECT * FROM users
            WHERE username LIKE '%{}%';
            """.format(query)
        )
    else:
        users = select('users')

    return render_template('users/list.html', users=users, query=query)


@users.route('/delete/<int:id>', methods=['GET'])
def delete(id):
    if session.get('user') == id:
        flash("Don't delete yourself, it's bad idea :)", 'error')
        return redirect(url_for('users.list'))

    try:
        run_custom_query(
            """DELETE FROM users WHERE ID = {}""".format(id),
            fetch=False
        )
        return redirect(url_for('users.list'))
    except IntegrityError:
        flash("User has got orders. Delete user's orders at first", 'error')

    return redirect(url_for('users.list'))
