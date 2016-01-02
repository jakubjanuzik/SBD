from collections import namedtuple
from app import utils


def create_client(form):
    clientData = {
        'name': form.data['name'],
        'surname': form.data['surname'],
        'email': form.data['email']
    }

    id = utils.insert('clients', clientData)
    for x in form.data["phones"]:
        utils.insert('client_phones', {'client_id': id, 'phone': x['phone']})


def get_client(id, abort=True):
    client = utils.select_one_or_404('clients', {'id': id})
    phones = utils.select('client_phones', {'client_id': id})

    Client = namedtuple('Client', ['name', 'surname', 'email', 'phones'])
    client = Client(
        name=client.name,
        surname=client.surname,
        email=client.email,
        phones=[{'phone': phone.phone} for phone in phones])

    return client
