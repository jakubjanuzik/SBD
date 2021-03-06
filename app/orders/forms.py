from flask_wtf import Form
from wtforms import Form as NoCsrfForm
from wtforms import (
    FieldList, FormField, SelectField, DecimalField, IntegerField
)
from wtforms.validators import DataRequired, NumberRange
from app import utils
from app.product.models import get_all_products
from app.clients.models import get_all_clients
from app.statuses.models import get_statuses_choices
from .models import Product

class NoValidateSelectField(SelectField):

    def pre_validate(self, form):
        pass


class OrderProductForm(NoCsrfForm):
    product = NoValidateSelectField('Product')
    price = DecimalField('Price', places=2, validators=[NumberRange(min=0, max=10000000000)])
    quantity = IntegerField('Quantity', validators=[NumberRange(min=1)])

    def __init__(self, *args, **kwargs):
        super(OrderProductForm, self).__init__(*args, **kwargs)
        self.product.choices = [
            (item.id, 'id:{}, {} - {}'.format(item.id, item.name, item.price))
            for item in get_all_products()
        ]


class OrderForm(Form):
    client = NoValidateSelectField('Client', validators=[DataRequired()])
    products = FieldList(
        FormField(OrderProductForm, default=lambda: Product()),
        min_entries=1
    )
    status = SelectField(
        'Status',
        validators=[DataRequired()],
    )

    def __init__(self, *args, **kwargs):
        super(OrderForm, self).__init__(*args, **kwargs)
        self.client.choices = [
            (item.id, item.name) for item in get_all_clients()
        ]
        self.status.choices = get_statuses_choices()
