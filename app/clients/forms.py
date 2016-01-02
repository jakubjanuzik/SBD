from flask_wtf import Form
from wtforms import StringField, FieldList, FormField
from wtforms.validators import DataRequired, Email


class PhoneForm(Form):
    phone = StringField('Phone number')


class UserForm(Form):
    name = StringField('Client name', validators=[DataRequired()])
    surname = StringField('Client surname', validators=[DataRequired()])
    email = StringField('Client email', validators=[DataRequired(), Email()])
    phones = FieldList(FormField(PhoneForm), min_entries=2)
