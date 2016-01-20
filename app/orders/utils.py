from app.utils import select
import ipdb; ipdb.set_trace()
from .models import Status


def get_initial_status():
    data = select('order_statuses', {'status_name': 'New'})

    import ipdb; ipdb.set_trace()
    return Status(**data.__dict__)

