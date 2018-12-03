#!/bin/bash
set -e

if [ -f "/etc/mysql/conf.d/docker-galera.cnf" ]; then
if [ -n "${WSREP_ROLE}" -a "${WSREP_ROLE}" = "seed" -a ! -s "/var/lib/mysql/grastate.dat" ] || \
   grep -e "^safe_to_bootstrap: 1$" "/var/lib/mysql/grastate.dat"; then
    echo "wsrep_new_cluster" >> /etc/mysql/conf.d/docker-galera.cnf
fi
fi

exit 0
