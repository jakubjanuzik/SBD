from app.product.models import Product
from app.clients.models import Cl, get_client
from app.utils import insert, select, select_one_or_404, update, delete

from flask import abort


def get_initial_status():
    data = select('order_statuses', {'status_name': 'New'})

    try:
        status = Status(id=data[0].id, name=data[0].status_name)
    except IndexError:
        abort(404)

    return status


def get_new_orders_for_user(user_id):
    initial_status_pk = get_initial_status().id
    orders = select(
        'orders',
        {'status_id': initial_status_pk, 'user_id': user_id}
    )
    data = []
    for order in orders:
        data.append(get_order(order.id))
    return data


def save_order(data):
    data_orders = {
        'client_id': data['client'],
        'status_id': get_initial_status().id,
        'user_id': data['user']
    }
    order_id = insert('orders', data_orders)

    for product in data['products']:
        data_products = {
            'order_id': order_id,
            'product_id': product['product'],
            'price': product['price'],
            'quantity': product['quantity'],
        }
        insert('order_products', data_products)


def get_order(id):
    order = select_one_or_404('orders', {'id': id})
    order_products = select('order_products', {'order_id': id})
    status = select(
        'order_statuses',
        {'id': order.status_id}
    )[0].status_name
    return Order(order.id, order.client_id, order_products, status)


def get_all_orders():
    orders_list = []
    orders = select('orders')
    for order in orders:
        order_products = select('order_products', {'order_id': order.id})
        status = select('order_statuses', {'id': order.status_id})[0]
        orders_list.append(
           Order(order.id, order.client_id, order_products, status.status_name)
        )
    return sorted(orders_list, key=lambda x: x.id)


def confirm_order(order_id):
    confirmed_status = select('order_statuses', {'status_name': 'Confirmed'})
    try:
        update(
            'orders',
            {'id': order_id},
            {'status_id': confirmed_status[0].id}
        )
    except:
        abort(404)


def cancel_order(order_id):
    cancelled_status = select('order_statuses', {'status_name': 'Cancelled'})
    try:
        update(
            'orders',
            {'id': order_id},
            {'status_id': cancelled_status[0].id}
        )
    except:
        abort(404)


def update_order(order_id, data):
    order_data = {
        'client_id': data['client'],
    }
    update('orders', {'id': order_id}, order_data)

    delete('order_products', {'order_id': order_id})

    for product in data['products']:
        data_products = {
            'order_id': order_id,
            'product_id': product['product'],
            'price': product['price'],
            'quantity': product['quantity'],
        }
        insert('order_products', data_products)


class Order(object):
    def __init__(self, id, client=None, products=None, status=None):
        self.client = client
        self.products = products
        self.id = id
        self.status = status
        if type(client) is int:
            self.client = get_client(client)
        elif type(client) is Cl:
            self.client = client

        if products:
            self.products = [
                Product(
                    id=product.product_id,
                    price=product.price,
                    quantity=product.quantity
                )
                for product in products
            ]

    def __repr__(self):
        return 'Order ID: {}'.format(self.id)


class Status(object):
    def __init__(self, id, name):
        self.id = id
        self.status_name = name

    def __repr__(self):
        return 'Status {}'.format(self.status_name)