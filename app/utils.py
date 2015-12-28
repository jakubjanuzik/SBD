import hashlib
import psycopg2
from psycopg2.extensions import AsIs
from flask import g


def insert_into_table(tablename, values):
    """
    Inserts data into given tablename, inspirated from Stack Overflow :-)
    """
    conn = getattr(g, 'db', None)
    cursor = conn.cursor()
    columns = list(values.keys())  # needed in Py3
    values = [values[column] for column in columns]
    insert_statement = 'insert into {} (%s) values %s'.format(tablename)
    cursor.execute(insert_statement, (AsIs(','.join(columns)), tuple(values)))
    conn.commit()
    cursor.close()


def insert_into_table_with_image(tablename, values):
    """
    Inserts data into given tablename, expects image to be under 'image' key
    """
    conn = getattr(g, 'db', None)
    cursor = conn.cursor()
    if values['image'].filename:
        values['image'] = psycopg2.Binary(values['image'].stream.read())
    else:
        values.pop('image')
    columns = list(values.keys())  # needed in Py3
    values = [values[column] for column in columns]
    insert_statement = 'insert into {} (%s) values %s'.format(tablename)
    cursor.execute(insert_statement, (AsIs(','.join(columns)), tuple(values)))
    conn.commit()
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
    data = cursor.fetchall()
    cursor.close()
    return data


def select_row_from_table_by_id(tablename, row_id):
    cursor = getattr(g, 'db', None).cursor()
    select_statement = 'SELECT * FROM {} WHERE id = %s;'.format(
        tablename
    )
    cursor.execute(select_statement, (row_id, ))
    data = cursor.fetchall()
    cursor.close()
    return data


def select_fields_from_table_by_ids(tablename, fields, ids_list):
    if not ids_list:
        raise ValueError('ids_list cannot be empty!')

    cursor = getattr(g, 'db', None).cursor()
    fields_string = ', '.join(fields)
    select_statement = 'SELECT {} FROM {} WHERE id = ANY(%s);'.format(
        fields_string, tablename
    )
    cursor.execute(select_statement, (ids_list, ))
    data = cursor.fetchall()
    cursor.close()
    return data


def check_auth(username, password):
    m = hashlib.md5()
    # In Py3 it's an unicode and must be encoded to be string/byte type.
    password = password.encode('utf-8')
    m.update(password)
    hashpass = m.hexdigest()
    data = run_custom_query(
        """SELECT * FROM users
        WHERE username = \'{}\'
        AND password = \'{}\'"""
        .format(username, hashpass)
    )

    if not data:
        return None
    else:
        return data[0]


def get_user_by_id(id):
    data = run_custom_query(
        """SELECT * FROM users
        WHERE user_id = \'{}\'"""
        .format(id)
    )

    if not data:
        return None
    else:
        return data[0]
