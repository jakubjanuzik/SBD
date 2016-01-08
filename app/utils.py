import os.path
import hashlib
import uuid
import psycopg2
from psycopg2.extensions import AsIs
from flask import g, abort
from werkzeug import secure_filename
from app import app


def insert_into_table(tablename, values):
    """
    Inserts data into given tablename, inspirated from Stack Overflow :-)
    """
    conn = getattr(g, 'db', None)
    cursor = conn.cursor()
    columns = list(values.keys())  # needed in Py3
    values = [values[column] for column in columns]
    insert_statement = 'insert into {} (%s) values %s RETURNING id'.format(
       tablename
    )
    cursor.execute(insert_statement, (AsIs(','.join(columns)), tuple(values)))
    id_of_new_row = cursor.fetchone()[0]
    conn.commit()
    cursor.close()
    return id_of_new_row


def insert(tablename, values):
    return insert_into_table(tablename, values)


def update(tablename, where, values):
    conn = getattr(g, 'db', None)
    cursor = conn.cursor()
    sql = """UPDATE {}
    SET {}
    WHERE {};""".format(
        tablename,
        ', '.join('{}=\'{}\''.format(k, values[k]) for k in values),
        ', '.join('{}=\'{}\''.format(k, where[k]) for k in where))
    cursor.execute(sql)
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


def run_custom_query(querystring, fetch=True):
    conn = getattr(g, 'db', None)
    cursor = conn.cursor()
    cursor.execute(querystring)
    if fetch:
        data = cursor.fetchall()
    conn.commit()
    cursor.close()
    if fetch:
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


def select(tablename, where_params={}):
    conn = getattr(g, 'db', None)
    cursor = conn.cursor()
    sql = 'SELECT * FROM {};'.format(tablename)

    if where_params:
        if type(where_params) == str:
            sql = sql[:-1] + ' WHERE {};'.format(where_params)
        elif type(where_params) == dict:
            sql = sql[:-1] + ' WHERE {};'.format(
                ' AND '.join(
                    '{}=\'{}\''.format(k, where_params[k])
                    for k in where_params)
            )

    cursor.execute(sql)
    data = cursor.fetchall()
    conn.commit()
    cursor.close()
    return data


def delete(tablename, where_params):
    conn = getattr(g, 'db', None)
    cursor = conn.cursor()
    sql = 'DELETE FROM {};'.format(tablename)

    if where_params:
        if type(where_params) == str:
            sql = sql[:-1] + ' WHERE {};'.format(where_params)
        elif type(where_params) == dict:
            sql = sql[:-1] + ' WHERE {};'.format(
                ' AND '.join(
                    '{}=\'{}\''.format(k, where_params[k])
                    for k in where_params)
            )

    cursor.execute(sql)
    conn.commit()
    cursor.close()


def select_one_or_404(tablename, where):
    data = select(tablename, where)
    try:
        data = data[0]
    except IndexError:
        abort(404)

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
        WHERE id = \'{}\'"""
        .format(id)
    )

    if not data:
        return None
    else:
        return data[0]


def save_image(image, product_id):
    filename = secure_filename(image.filename)
    img_data = {
        "filename": '{}-{}'.format(
            hashlib.md5(
                str(uuid.uuid4()).encode('utf-8')
            ).hexdigest(),
            image.filename
        ),
        "caption": filename,
        "product_id": product_id,
    }
    image.save(
        os.path.join(
            app.config["IMAGE_UPLOAD_PATH"],
            img_data["filename"]
        )
    )
    insert_into_table('product_images', img_data)
