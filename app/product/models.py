from app import utils


def get_product_main_image(id):
    images = utils.run_custom_query("""
        SELECT * FROM product_images
        WHERE product_id = {}
        ORDER BY default_image DESC
        """.format(id))

    if not images:
        return None
    else:
        return images[0]


def get_product_images(id):
    return utils.run_custom_query(
        """SELECT * FROM {}
        WHERE product_id = {}
        AND deleted={};""".format("product_images", id, False))
