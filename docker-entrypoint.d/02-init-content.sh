#!/bin/sh
set -e

if [ -z "${WSREP_CLUSTER_ROLE}" -o "${WSREP_CLUSTER_ROLE}" = "seed" ]; then
if [ ! -d "mysql/mysql" ]; then
    tar xfvz mysql-content.tar.gz
fi
fi

exit 0
