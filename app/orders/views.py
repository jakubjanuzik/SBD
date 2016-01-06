from flask import (
    render_template
)
from . import orders
from .forms import OrderForm
from app.decorators import login_required


@login_required
@orders.route('/create/', methods=['GET', 'POST'])
def create():
    form = OrderForm()

    if form.validate_on_submit():
        pass
    return render_template('orders/create.html', form=form)


@login_required
@orders.route('/', methods=['GET', 'POST'])
def list():
    pass
