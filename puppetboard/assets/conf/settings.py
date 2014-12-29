def str2bool(value):
	return value.lower() in ("true", "yes", "on", "1")

LOGLEVEL = 'info'
PUPPETDB_HOST = "{{ PUPPETDB_HOST }}"
PUPPETDB_PORT = int("{{ PUPPETDB_PORT }}")
PUPPETDB_SSL_VERIFY = str2bool("{{ PUPPETDB_VERIFY }}")

if not "localhost" in PUPPETDB_HOST:
	PUPPETDB_KEY = "/webapps/puppetboard/ssl/puppetboard.pem"
	PUPPETDB_CERT = "/webapps/puppetboard/ssl/puppetboard.crt"

PUPPETDB_TIMEOUT = 20
UNRESPONSIVE_HOURS = 3
ENABLE_QUERY = True
LOCALISE_TIMESTAMP = True
PUPPETDB_EXPERIMENTAL = False
REPORTS_COUNT = 10
