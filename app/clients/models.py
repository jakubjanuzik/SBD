from collections import namedtuple

from app import utils


def create_client(form):
    client_data = {
        'name': form.data['name'],
        'surname': form.data['surname'],
        'email': form.data['email']
    }

    client_id = utils.insert('clients', client_data)
    for phone in form.data['phones']:
        if phone['phone']:
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
        if phone['phone']:
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
        phones=[{'id': phone.id, 'phone': phone.phone} for phone in phones])
    c = Cl(client)
    return c


def get_full_client_dict(client):
    client_dict = dict(client.__dict__)  # Kinda hack  :-) Don't learn that :P
    phones = utils.run_custom_query(
        '''SELECT phone FROM client_phones WHERE client_id = {}'''.format(
            client.id
        )
    )
    client_dict['phones'] = [phone.phone for phone in phones if phone.phone]
    return client_dict


def get_phones_for_client(client):
    phones = utils.run_custom_query(
        '''SELECT phone FROM client_phones WHERE client_id = {}'''.format(
            client.id
        )
    )
    return [phone.phone for phone in phones if phone.phone]


def get_all_clients(where_params={}):
    clients = utils.select('clients', where_params)
    clients_list = []
    for client in clients:
        clients_list.append(get_client(client.id))
    return clients_list


class Cl():

    def __init__(self, data):
        self.id = data.id
        self.name = data.name
        self.surname = data.surname
        self.email = data.email
        self.phones = [
            Ph(phone=phone['phone']) for phone in data.phones if phone
        ]

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'surname': self.surname,
            'email': self.email,
            'phones': [phone.serialize() for phone in self.phones],
            'label': 'ID: {}, {} {}'.format(self.id, self.name, self.surname)
        }

    def __repr__(self):
        return 'Client ID: {}, {} {}'.format(self.id, self.name, self.surname)


class Ph():

    def __init__(self, phone):
        self.phone = phone

    def serialize(self):
        return {
            'phone': self.phone,
        }
