import multiprocessing

GUN_CONF_RELOAD_ENGINE = 'auto'
GUN_CONF_RELOAD_EXTRA_FILES = []
GUN_CONF_ACESS_LOG = None
GUN_CONF_ACESS_LOG_FORMAT = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'
GUN_CONF_LOG_LEVEL = lambda x: 'info' if x else 'debug'
GUN_CONF_RELOAD = lambda x: False if x else True
GUN_CONF_LOG_CONFIG = None
GUN_CONF_PROCESS_NAME = 'API-CELEPAR-PROCESS'
GUN_CONF_LIMIT_REQUEST_LINE = 4094 # DEFAULT
GUN_CONF_LIMIT_REQUEST_FIELDS = 100 # DEFAULT
GUN_CONF_LIMIT_REQUEST_FIELD_SIZE = 10485760 # 10MB
GUN_CONF_URL = lambda x, y: [f"0.0.0.0:{y}"] if x == '*' else [f"{x}:{y}"]
GUN_CONF_BACKLOG = 2048 # DEFAULT
GUN_CONF_WORKER_CONNECTIONS = 2000
GUN_CONF_MAX_REQUEST = 1000
GUN_CONF_MAX_REQUESTS_JITTER = 500
GUN_CONF_TIMEOUT = 60
GUN_CONF_WORKER_CLASS = 'uvicorn.workers.UvicornWorker'
GUN_CONF_WORKERS = 2
GUN_CONF_THREADS = 5
GUN_CONF_GRACEFUL_TIMEOUT = GUN_CONF_TIMEOUT + 10
GUN_CONF_KEEP_ALIVE = 10
CONF_PRODUCTION = False

bind = "0.0.0.0:7979"
workers = GUN_CONF_WORKERS  * multiprocessing.cpu_count() + 1
threads = GUN_CONF_THREADS * multiprocessing.cpu_count()
max_requests = GUN_CONF_MAX_REQUEST
max_requests_jitter = GUN_CONF_MAX_REQUESTS_JITTER
timeout = GUN_CONF_TIMEOUT
graceful_timeout = GUN_CONF_GRACEFUL_TIMEOUT
keepalive = GUN_CONF_KEEP_ALIVE
backlog = GUN_CONF_BACKLOG
worker_connections = GUN_CONF_WORKER_CONNECTIONS
worker_class = GUN_CONF_WORKER_CLASS
reload = GUN_CONF_RELOAD(CONF_PRODUCTION)
reload_engine = GUN_CONF_RELOAD_ENGINE
reload_extra_files = GUN_CONF_RELOAD_EXTRA_FILES
accesslog = GUN_CONF_ACESS_LOG
access_log_format = GUN_CONF_ACESS_LOG_FORMAT
loglevel = GUN_CONF_LOG_LEVEL(CONF_PRODUCTION)
logconfig = GUN_CONF_LOG_CONFIG
proc_name = GUN_CONF_PROCESS_NAME
limit_request_line = GUN_CONF_LIMIT_REQUEST_LINE
limit_request_fields = GUN_CONF_LIMIT_REQUEST_FIELDS
limit_request_field_size = GUN_CONF_LIMIT_REQUEST_FIELD_SIZE
proxy_allow_ips = "*"