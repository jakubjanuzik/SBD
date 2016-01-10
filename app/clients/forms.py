from flask_wtf import Form
from wtforms import Form as NoCsrfForm
from wtforms import StringField, FieldList, FormField, SelectField
from wtforms.validators import DataRequired, Email
from .models import Ph


class PhoneForm(NoCsrfForm):
    phone = StringField('Phone number')


class AddressForm(NoCsrfForm):
    street = StringField('Street', validators=[DataRequired()])
    city = StringField('City', validators=[DataRequired()])
    country = SelectField(
        'Country', validators=[DataRequired()], choices=[('PL', 'Poland')]
    )


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
        AddressForm,
        label='Billing Address',
    )
    delivery_address = FormField(
        AddressForm,
        label='Delivery Address',
    )
