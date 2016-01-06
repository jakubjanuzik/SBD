from app import utils


def get_product_main_image(id):
    images = utils.run_custom_query("""
        SELECT * FROM product_images
        WHERE product_id = {}
        ORDER BY default_image DESC
        """.format(id))

    if not images:
        return None
    return images[0]


def get_product_images(id):
    return utils.run_custom_query(
        """SELECT * FROM {}
        WHERE product_id = {}
        AND deleted={};""".format("product_images", id, False))


def get_product(id):
    product = utils.select_one_or_404('product', {'id': id})
    images = utils.select('product_images', {'product_id': id})

    c = Product(
        product.id,
        product.name,
        product.price,
        product.description,
        [image.filename for image in images]
    )
    return c


def get_all_products(where_params={}):
    products = utils.select('product', where_params)
    products_list = []
    for product in products:
        products_list.append(get_product(product.id))
    return products_list


class Product():

    def __init__(self, id, name='', price=0.0, description='', images=[]):
        self.id = id
        self.name = name
        self.price = str(price)
        self.description = description
        self.images = images

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'price': self.price,
            'description': self.description,
            'images': self.images,
        }
