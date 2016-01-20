from flask_wtf import Form
from wtforms import StringField
from wtforms.validators import DataRequired


class StatusForm(Form):
    status_name = StringField('Status Name', validators=[DataRequired()])
