from flask import render_template, redirect, url_for
from . import product
from .forms import ProductForm
from app.decorators import login_required
from app.utils import insert_into_table_with_image


@login_required
@product.route('/create/', methods=['GET', 'POST'])
def create_product():
    form = ProductForm()
    if form.validate_on_submit():
        insert_into_table_with_image('product', form.data)
        return redirect(url_for('index'))

    return render_template('products/create.html', form=form)
