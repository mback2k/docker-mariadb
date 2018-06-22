#!/bin/sh
set -e

if [ ! -f "/etc/mysql/debian.cnf" ]; then
    touch /etc/mysql/debian.cnf
    chown root:root /etc/mysql/debian.cnf
    chmod 600 /etc/mysql/debian.cnf
fi

if [ ! -f "/etc/mysql/docker-init-file.sql" ]; then
    touch /etc/mysql/docker-init-file.sql
    chown root:mysql /etc/mysql/docker-init-file.sql
    chmod 640 /etc/mysql/docker-init-file.sql
fi

exit 0
