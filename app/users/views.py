from . import users
from flask import render_template, request, session, url_for, redirect, flash
from .forms import LoginForm

from app.utils import check_auth


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
