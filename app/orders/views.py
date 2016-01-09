from flask import (
    render_template, redirect, url_for
)
from . import orders
from .forms import OrderForm
from .models import Order, save_order, get_all_orders, get_order, update_order
from app.clients.models import get_all_clients
from app.product.models import get_all_products
from app.decorators import login_required
import jsonpickle


@login_required
@orders.route('/create/', methods=['GET', 'POST'])
def create():
    form = OrderForm()
    if form.validate_on_submit():
        save_order(form.data)
        return redirect(url_for('orders.list'))

    clients = get_all_clients()
    form.client.choices = [
        (item.id, '{} {}'.format(item.name, item.surname)) for item in clients
    ]
    client_choices = jsonpickle.dumps(clients)

    products = get_all_products()
    product_choices = {}
    for product in products:
        product_choices[product.id] = {
            'id': product.id,
            'price': product.string_price,
        }
    product_choices = jsonpickle.dumps(product_choices)

    return render_template(
        'orders/create.html',
        form=form,
        client_choices=client_choices,
        product_choices=product_choices)


@login_required
@orders.route('/edit/<int:order_id>', methods=['GET', 'POST'])
def edit(order_id):
    order = get_order(order_id)
    order.client = order.client.id
    form = OrderForm(obj=order)
    if form.validate_on_submit():
        update_order(order_id, form.data)
        redirect(url_for('orders.list'))

    clients = get_all_clients()
    form.client.choices = [
        (item.id, '{} {}'.format(item.name, item.surname)) for item in clients
    ]
    client_choices = jsonpickle.dumps(clients)

    products = get_all_products()
    product_choices = {}
    for product in products:
        product_choices[product.id] = {
            'id': product.id,
            'price': product.string_price,
        }
    product_choices = jsonpickle.dumps(product_choices)

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
