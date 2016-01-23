from app import utils

def create_status(data):
    utils.insert('order_statuses', data)

def update_status(status_id, data):
    utils.update('order_statuses', {'id': status_id}, data)

def delete_status(status_id):
    utils.run_custom_query(
        """DELETE FROM order_statuses WHERE ID = {}""".format(status_id),
        fetch=False
    )

def get_all_statuses():
    statuses = utils.select('order_statuses')
    return [Status(record) for record in statuses]

def get_statuses_choices():
    statuses = utils.select('order_statuses')
    return [(record.status_name, record.status_name) for record in statuses]

class Status(object):

    def __init__(self, record):
        self.id = record.id
        self.name = record.status_name
