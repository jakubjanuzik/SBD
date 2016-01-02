from collections import namedtuple

from flask import abort
from psycopg2 import ProgrammingError
from app import utils


def create_client(form):
    client_data = {
        'name': form.data['name'],
        'surname': form.data['surname'],
        'email': form.data['email']
    }

    client_id = utils.insert('clients', client_data)
    for phone in form.data['phones']:
        utils.insert(
            'client_phones', {'client_id': client_id, 'phone': phone['phone']}
        )


def edit_client(form, client_id):
    client_data = {
        'name': form.data['name'],
        'surname': form.data['surname'],
        'email': form.data['email'],
    }

    utils.run_custom_query(
            """DELETE FROM CLIENT_PHONES WHERE CLIENT_ID = {}""".format(
                client_id
            ),
            fetch=False
        )
    utils.update('clients', {'id': client_id},  client_data)
    for phone in form.data['phones']:
        utils.insert(
            'client_phones',
            {'client_id': client_id, 'phone': phone['phone']}
        )


def get_client(id):
    client = utils.select_one_or_404('clients', {'id': id})
    phones = utils.select('client_phones', {'client_id': id})

    Client = namedtuple(
        'Client', ['id', 'name', 'surname', 'email', 'phones']
    )
    client = Client(
        id=client.id,
        name=client.name,
        surname=client.surname,
        email=client.email,
        phones=[{'phone': phone.phone} for phone in phones])

    return client
