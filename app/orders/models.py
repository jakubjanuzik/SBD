from app.product.models import Product
from app.clients.models import Cl, get_client
from app.utils import insert, select, select_one_or_404, update, delete

def save_order(data):
    data_orders = {
        'client_id': data['client'],
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
    return Order(order.id, order.client_id, order_products)

def get_all_orders():
    orders_list = []
    orders = select('orders')
    for order in orders:
        order_products = select('order_products', {'order_id': order.id})
        orders_list.append(Order(order.id, order.client_id, order_products))

    return orders_list


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

    def __init__(self, id, client=None, products = []):
        self.client = None
        self.products = []
        self.id = id
        self.order = id

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
