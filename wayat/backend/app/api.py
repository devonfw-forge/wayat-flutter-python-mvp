from app.business.router import all_router
from app.common.core import get_api
from app.common.infra.gcp.cloud_logging import CloudRunLoggingMiddleware

api = get_api(routers=[all_router])
api.add_middleware(CloudRunLoggingMiddleware)
