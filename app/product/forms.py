from flask_wtf import Form
from wtforms import (
    StringField, FileField, ValidationError, DecimalField, TextAreaField
)
from wtforms.validators import DataRequired, NumberRange
# from werkzeug import secure_filename
from decimal import ROUND_HALF_UP
from app import app
from flask import abort


class ProductForm(Form):
    name = StringField('Product Name', validators=[DataRequired()])
    description = TextAreaField(
        'Product description', validators=[DataRequired()]
    )
    images = FileField('Image File')
    price = DecimalField(
        'Product price',
        places=2,
        rounding=ROUND_HALF_UP,
        validators=[NumberRange(min=0, max=10000000000)])

    def validate_price(form, field):
        if field.data is None:
            field.data = 0

    def validate_image(form, field):
        if field.data:
            if not (
                field.data.filename.endswith(app.config['ALLOWED_IMAGES_EXT'])
            ):
                raise ValidationError('Incorrect image extension')

    def prepopulate_data(form, data):
        try:
            form.name.data = data.name
            form.price.data = data.price
            form.description.data = data.description
        except TypeError:
            abort(500)
