from flask_wtf import Form
from wtforms import StringField, FieldList
from wtforms.validators import DataRequired, Email


class UserForm(Form):
    name = StringField('Client name', validators=[DataRequired()])
    surname = StringField('Client surname', validators=[DataRequired()])
    phone = StringField('Client phone', validators=[DataRequired()])
    email = StringField('Client email', validators=[DataRequired(), Email()])
    phones = FieldList(StringField('Cleint phones', DataRequired()))
