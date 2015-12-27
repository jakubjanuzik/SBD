import hashlib
from app.utils import run_custom_query


def check_auth(username, password):
    m = hashlib.md5()
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
