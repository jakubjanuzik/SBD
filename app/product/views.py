from flask import (
    render_template, redirect, url_for, request, flash, abort, jsonify
)
from psycopg2 import IntegrityError
from . import product
from .forms import ProductForm
from .models import get_product_images, get_all_products
from app.decorators import login_required
from app.utils import (
    insert_into_table, run_custom_query, select_row_from_table_by_id, update,
    save_image
)


@login_required
@product.route('/create/', methods=['GET', 'POST'])
def create_product():
    form = ProductForm()

    if form.validate_on_submit():

        data = form.data.copy()
        data.pop("images", None)
        try:
            product_id = insert_into_table('products', data)
        except IntegrityError:
            form.name.errors = ('Product with given name already exists',)
            return render_template('products/create.html', form=form)
        images = request.files.getlist("images")
        if images:
            for image in images:
                    save_image(image, product_id)
            return redirect(url_for('product.list'))

    return render_template('products/create.html', form=form)


@login_required
@product.route('/', methods=['GET'])
def list():
    query = request.args.get('query', '')
    if not query:
        products = run_custom_query(
            """SELECT * FROM products
            WHERE deleted = False""")
    else:
        products = run_custom_query(
            """
                SELECT * FROM products
                WHERE (LOWER(name) LIKE '%{0}%'
                    OR LOWER(description) LIKE '%{0}%')
                AND deleted = False
            """.format(query.lower())
        )

    return render_template(
        'products/list.html',
        products=products,
        query=query
    )


@login_required
@product.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit(id):
    product = select_row_from_table_by_id("products", id)
    images = []
    try:
        product = product[0]
    except IndexError:
        abort(404)

    form = ProductForm()
    if request.method == 'GET':
        form.prepopulate_data(product)
        images = get_product_images(id)

    if form.validate_on_submit():
        data = form.data.copy()
        data.pop("images", None)
        try:
            update("products", {"id": id}, data)
        except IntegrityError:
            form.name.errors = ('Product with given name already exists',)
            render_template('products/create.html', form=form)
        images = request.files.getlist("images")
        if images:
            for image in images:
                if image.filename:
                    save_image(image, product.id)
            return redirect(url_for('product.edit', id=id))

    return render_template('products/edit.html', form=form, images=images)


@login_required
@product.route('/delete/<int:id>', methods=['GET'])
def delete(id):
    product = select_row_from_table_by_id("products", id)
    if product is not None:
        run_custom_query("""SELECT delete_product({})""".format(id), fetch=False)
        flash(
            "Succesfully deleted product {}".format(product[0].name),
            "success"
        )
    else:
        flash("Product with ID={} does not exist".format(id), "danger")

    return redirect(url_for('product.list'))


@login_required
@product.route('/delete_image/<int:id>', methods=['GET'])
def delete_image(id):
    run_custom_query("""UPDATE product_images
        SET deleted = {}
        WHERE id = \'{}\'""".format(True, id), fetch=False)

    return jsonify({
        'success': True
    })
