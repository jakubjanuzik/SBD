from flask_wtf import Form
from wtforms import Form as NoCsrfForm
from wtforms import (
    StringField, FieldList, FormField, SelectField, ValidationError
)
from wtforms.validators import DataRequired, Email
from .models import Ph


class PhoneForm(NoCsrfForm):
    phone = StringField('Phone number')


class BillingAddressForm(NoCsrfForm):
    street = StringField('Street', validators=[DataRequired()])
    city = StringField('City', validators=[DataRequired()])
    country = SelectField(
        'Country', validators=[DataRequired()], choices=[
            ('', '-------'),
            ('PL', 'Poland'),
        ]
    )

class DeliveryAddressForm(NoCsrfForm):
    street = StringField('Street')
    city = StringField('City')
    country = SelectField(
        'Country',
         choices=[
            ('', '-------'),
            ('PL', 'Poland'),
        ]
    )

    def validate(self, *args, **kwargs):
        values = self.data.values()
        if any(values):
            if not all(values):
                for field, data in self.data.items():
                    if not data:
                        getattr(self, field).errors = (
                            'Missing {}!'.format(field),
                        )
                return False
        return super().validate()


class UserForm(Form):
    name = StringField('Client name', validators=[DataRequired()])
    surname = StringField('Client surname', validators=[DataRequired()])
    email = StringField('Client email', validators=[DataRequired(), Email()])
    phones = FieldList(
        FormField(
            PhoneForm,
            default=lambda: Ph(phone='')
        ),
        min_entries=2,
    )
    billing_address = FormField(
        BillingAddressForm,
        label='Billing Address',
    )

    delivery_address = FormField(
        DeliveryAddressForm,
        label='Delivery Address',
    )
