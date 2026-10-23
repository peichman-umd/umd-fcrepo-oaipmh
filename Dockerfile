FROM python:3.11-slim-bookworm

# The base image's pip bundles an outdated CA file; upgrade it, verifying the download against the OS store
RUN PIP_CERT=/etc/ssl/certs/ca-certificates.crt pip install --no-cache-dir --upgrade "pip>=26.2.2"

EXPOSE 5000

WORKDIR /opt/umd-fcrepo-oaipmh

COPY requirements.txt /opt/umd-fcrepo-oaipmh/
RUN pip install -r requirements.txt
COPY src pyproject.toml /opt/umd-fcrepo-oaipmh/
RUN pip install -e .

ENTRYPOINT ["fcrepo-oaipmh-server"]
