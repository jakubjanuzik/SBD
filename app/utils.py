from psycopg2.extensions import AsIs
from flask import g


def insert_into_table(tablename, values):
    """
    Inserts data into given tablename, inspirated from Stack Overflow :-)
    """
    cursor = getattr(g, 'db', None).cursor()
    columns = list(values.keys())  # needed in Py3
    values = [values[column] for column in columns]
    insert_statement = 'insert into {} (%s) values %s'.format(tablename)
    cursor.execute(insert_statement, (AsIs(','.join(columns)), tuple(values)))
    cursor.close()


def select_all_from_table(tablename):
    cursor = getattr(g, 'db', None).cursor()
    cursor.execute('SELECT * FROM {}'.format(tablename))
    data = cursor.fetchall()
    cursor.close()
    return data


def run_custom_query(querystring):
    cursor = getattr(g, 'db', None).cursor()
    cursor.execute(querystring)
    cursor.close()


def select_fields_from_table_by_ids(tablename, fields, ids_list):
    if not ids_list:
        raise ValueError('ids_list cannot be empty!')

    cursor = getattr(g, 'db', None).cursor()
    fields_string = ', '.join(fields)
    select_statement = 'SELECT %s FROM {} WHERE id = ANY(%s);'.format(
        tablename
    )
    cursor.execute(select_statement, fields_string, ids_list)
    data = cursor.fetchone()
    cursor.close()
    return data
