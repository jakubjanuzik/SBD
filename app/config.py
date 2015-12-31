import os.path

SECRET_KEY = '013hgb0qcf03ks-3nmsdfa'
DATABASE_CREDENTIALS = {
    'dbname': 'sbd',
    'user': 'kuba',
}

WTF_CSRF_ENABLED = True
BASE_PATH = os.path.dirname(os.path.abspath(__file__))
ALLOWED_IMAGES_EXT = ('.png', '.jpg', '.jpeg')
IMAGE_PATH = 'media/images'
IMAGE_UPLOAD_PATH = os.path.join(BASE_PATH, 'media/images')

try:
    from app.dev_config import *
except Exception as e:
    pass
