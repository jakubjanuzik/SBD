from flask_wtf import Form
from wtforms import Form as NoCsrfForm
from wtforms import (
    StringField, FieldList, FormField, SelectField, DecimalField
)
from wtforms.validators import DataRequired
from app.product.models import get_all_products
from app.clients.models import get_all_clients


class NoValidateSelectField(SelectField):

    def pre_validate(self, form):
        pass


class OrderProductForm(NoCsrfForm):
    product = NoValidateSelectField('Product', choices=[])
    price = DecimalField('Price', places=2)

    # def __init__(self, *args, **kwargs):
    #     super(OrderProductForm, self).__init__(*args, **kwargs)
    #     self.product.choices = [
    #         (item.id, item.name) for item in get_all_products()
    #     ]


class OrderForm(Form):
    client = NoValidateSelectField('Client', validators=[DataRequired()], choices=[])
    products = FieldList(FormField(OrderProductForm), min_entries=2)

    # def __init__(self, *args, **kwargs):
    #     super(OrderForm, self).__init__(*args, **kwargs)
    #     self.client.choices = [
    #         (item.id, 'id:{}, {} {}'.format(item.id, item.name, item.surname))
    #         for item in get_all_clients()
    #     ]
