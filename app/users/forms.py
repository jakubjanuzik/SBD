from flask_wtf import Form
from wtforms import StringField, PasswordField
from wtforms.validators import DataRequired, EqualTo


class LoginForm(Form):
    username = StringField('username', validators=[DataRequired()])
    password = PasswordField('password', validators=[DataRequired()])


class UserForm(Form):
    username = StringField('username', validators=[DataRequired()])
    password = PasswordField(
        'password',
        validators=[
            DataRequired(),
            EqualTo('confirm', message='Passwords must match')
        ]
    )
    confirm = PasswordField('password', validators=[DataRequired()])

    def __init__(self, *args, **kwargs):
        self._obj = kwargs.get('obj', None)
        super(UserForm, self).__init__(*args, **kwargs)

    def validate(self, *args, **kwargs):
        if self._obj is not None and self.data['password'] == '' and self.data['confirm'] == '':
            return self.username.validate(form=self, *args, **kwargs)
        else:
            return super().validate()
