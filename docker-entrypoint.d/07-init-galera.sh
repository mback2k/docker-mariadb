#!/bin/bash
set -e

if [ ! -f "/etc/mysql/conf.d/docker-galera.cnf" ]; then
    exit 0
fi

if [ -n "${WSREP_ROLE}" -a "${WSREP_ROLE}" = "seed" -a ! -s "/var/lib/mysql/grastate.dat" ] || \
   grep -e "^safe_to_bootstrap: 1$" "/var/lib/mysql/grastate.dat"; then
    echo "wsrep_new_cluster" >> /etc/mysql/conf.d/docker-galera.cnf
fi

echo "Undefined" > /var/lib/mysql/docker-galera.state

chown mysql:mysql /var/lib/mysql/docker-galera.state
chmod 660 /var/lib/mysql/docker-galera.state

chown root:mysql /etc/mysql/debian.cnf
chmod 640 /etc/mysql/debian.cnf

exit 0
