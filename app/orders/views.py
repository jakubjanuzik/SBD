from flask import (
    render_template, redirect, url_for, session
)
from . import orders
from .forms import OrderForm
from .models import (
    save_order, get_all_orders, get_order, update_order,
    get_new_orders_for_user, confirm_order, cancel_order
)
from app.clients.models import get_all_clients
from app.product.models import get_all_products
from app.decorators import login_required
import jsonpickle


@login_required
@orders.route('/create/', methods=['GET', 'POST'])
def create():
    form = OrderForm()
    if form.validate_on_submit():
        data = form.data
        data['user'] = session.get('user')
        save_order(data)
        redirect(url_for('orders.list'))

    clients = get_all_clients()
    form.client.choices = [
        (item.id, '{} {}'.format(item.name, item.surname)) for item in clients
    ]
    client_choices = jsonpickle.dumps(clients)

    products = get_all_products()
    product_choices = jsonpickle.dumps(products)
    return render_template(
        'orders/create.html',
        form=form,
        client_choices=client_choices,
        product_choices=product_choices
    )


@login_required
@orders.route('/edit/<int:order_id>', methods=['GET', 'POST'])
def edit(order_id):
    order = get_order(order_id)
    form = OrderForm(obj=order)

    if form.validate_on_submit():
        form.populate_obj(order)
        update_order(order_id, form.data)
        redirect(url_for('orders.list'))

    clients = get_all_clients()
    form.client.choices = [
        (item.id, '{} {}'.format(item.name, item.surname)) for item in clients
    ]
    client_choices = jsonpickle.dumps(clients)

    products = get_all_products()
    product_choices = jsonpickle.dumps(products)

    return render_template(
        'orders/create.html',
        form=form,
        client_choices=client_choices,
        product_choices=product_choices
    )


@login_required
@orders.route('/', methods=['GET', 'POST'])
def list():
    orders_list = get_all_orders()

    return render_template('orders/list.html', orders=orders_list)


@login_required
@orders.route('/my', methods=['GET', 'POST'])
def my_orders():
    user_id = session.get('user')
    new_orders = get_new_orders_for_user(user_id)
    return render_template('orders/my_orders.html', orders=new_orders)


@login_required
@orders.route('/confirm/<int:order_id>', methods=['GET', 'POST'])
def confirm(order_id):
    confirm_order(order_id)
    return redirect(url_for('orders.my_orders'))


@login_required
@orders.route('/cancel/<int:order_id>', methods=['GET', 'POST'])
def cancel(order_id):
    cancel_order(order_id)
    return redirect(url_for('orders.my_orders'))
