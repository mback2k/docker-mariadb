#!/bin/sh
set -e

if [ -f "${MYSQL_ROOT_PASSWORD_FILE}" ]; then
    MYSQL_ROOT_PASSWORD="$(< "${MYSQL_ROOT_PASSWORD_FILE}")"
fi

if [ -n "${MYSQL_ROOT_PASSWORD}" ]; then
if [ -n "${WSREP_CLUSTER_ADDRESS}" ]; then
if [ -n "${WSREP_CLUSTER_NAME}" ]; then
if [ -n "${WSREP_NODE_ADDRESS}" ]; then
if [ -n "${WSREP_NODE_NAME}" ]; then
    touch /etc/mysql/conf.d/docker-galera.cnf
    chown root:mysql /etc/mysql/conf.d/docker-galera.cnf
    chmod 640 /etc/mysql/conf.d/docker-galera.cnf
    WSREP_NODE_ADDRESS=$(getent hosts $(hostname) | awk '{print $1}' | grep -e "${WSREP_NODE_ADDRESS}")
    echo "[galera]" > /etc/mysql/conf.d/docker-galera.cnf
    echo "wsrep_on=ON" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "wsrep_provider='/usr/lib/galera/libgalera_smm.so'" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "wsrep_cluster_address='gcomm://${WSREP_CLUSTER_ADDRESS}'" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "wsrep_cluster_name='${WSREP_CLUSTER_NAME}'" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "wsrep_node_address='${WSREP_NODE_ADDRESS}'" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "wsrep_node_name='${WSREP_NODE_NAME}'" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "wsrep_sst_auth='root:${MYSQL_ROOT_PASSWORD}'" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "wsrep_sst_method=mysqldump" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "binlog_format=ROW" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "log_bin=/var/log/mysql/mysql-bin.log" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "log_slave_updates" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "default_storage_engine=InnoDB" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "innodb_autoinc_lock_mode=2" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "innodb_doublewrite=1" >> /etc/mysql/conf.d/docker-galera.cnf
    echo "innodb_locks_unsafe_for_binlog=1" >> /etc/mysql/conf.d/docker-galera.cnf
fi
fi
fi
fi
fi

unset MYSQL_ROOT_PASSWORD

exit 0
