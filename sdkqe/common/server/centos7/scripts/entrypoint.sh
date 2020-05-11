#!/bin/bash
set -e

# Install couchbase
filename=$(basename ${PACKAGE_FILE})
cp -f ${PACKAGE_FILE} /tmp/${filename} && \
  rpm -Uvh /tmp/${filename}

[[ "$1" == "couchbase-server" ]] && {
    echo "Starting Couchbase Server -- Web UI available at http://<ip>:8091"
    exec /usr/sbin/runsvdir-start
}

exec "$@"
