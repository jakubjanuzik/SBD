SECRET_KEY = '013hgb0qcf03ks-3nmsdfa'
DATABASE_CREDENTIALS = {
    'dbname': 'sbd',
    'user': 'kuba',
}

WTF_CSRF_ENABLED = True

try:
    from dev_config import *
except Exception, e:
    pass
