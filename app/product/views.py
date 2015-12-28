from flask import render_template, redirect, url_for, request, flash, abort, jsonify
from . import product
from .forms import ProductForm
from .models import get_product_images, get_product_main_image
from app.decorators import login_required
from app.utils import insert_into_table, run_custom_query, select_row_from_table_by_id, update
from werkzeug import secure_filename
import os.path
from app import app
import uuid
import hashlib

@login_required
@product.route('/create/', methods=['GET', 'POST'])
def create_product():
    form = ProductForm()

    if form.validate_on_submit():

        data = form.data.copy()
        data.pop("images", None)
        product_id = insert_into_table('product', data)
        images = request.files.getlist("images")
        if images:
            for image in images:
                filename = secure_filename(image.filename)
                img_data = {
                    "filename": '{}-{}'.format(hashlib.md5(str(uuid.uuid4())).hexdigest(), image.filename),
                    "caption": filename,
                    "product_id": product_id,
                }
                image.save(os.path.join(app.config["IMAGE_UPLOAD_PATH"], img_data["filename"]))
                insert_into_table('product_images', img_data)
            return redirect(url_for('index'))

    return render_template('products/create.html', form=form)


@login_required
@product.route('/', methods=['GET'])
def list():
    products = run_custom_query(
        """SELECT * FROM product
        WHERE deleted = False""")

    return render_template('products/list.html', products=products)


@login_required
@product.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit(id):
    product = select_row_from_table_by_id("product", id)
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
        update("product", {"id": id}, data)
        images = request.files.getlist("images")
        if images:
            for image in images:
                if image.filename != '':
                    filename = secure_filename(image.filename)
                    img_data = {
                        "filename": '{}-{}'.format(hashlib.md5(str(uuid.uuid4())).hexdigest(), image.filename),
                        "caption": filename,
                        "product_id": product.id,
                    }
                    image.save(os.path.join(app.config["IMAGE_UPLOAD_PATH"], img_data["filename"]))
                    insert_into_table('product_images', img_data)
            return redirect(url_for('product.edit', id=id))

    return render_template('products/edit.html', form=form, images=images)


@login_required
@product.route('/delete/<int:id>', methods=['GET'])
def delete(id):
    product = select_row_from_table_by_id("product", id)
    if product is not None:
        run_custom_query("""UPDATE product
            SET deleted = {}
            WHERE id = \'{}\'""".format(True, id), fetch=False)
        flash("Succesfully deleted product {}".format(product[0].name), "success")
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
