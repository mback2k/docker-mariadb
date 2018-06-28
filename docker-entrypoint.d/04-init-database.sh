#!/bin/bash
set -e

if [ -f "${MYSQL_PASSWORD_FILE}" ]; then
    MYSQL_PASSWORD="$(< "${MYSQL_PASSWORD_FILE}")"
fi

if [ -n "${MYSQL_DATABASE}" ]; then
if [ -f "/etc/mysql/docker-init-file.sql" ]; then
    echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" >> /etc/mysql/docker-init-file.sql
fi
fi

if [ -n "${MYSQL_USER}" ]; then
if [ -n "${MYSQL_PASSWORD}" ]; then
if [ -f "/etc/mysql/docker-init-file.sql" ]; then
    echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'${MYSQL_USER_HOST}' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> /etc/mysql/docker-init-file.sql
    echo "SET PASSWORD FOR '${MYSQL_USER}'@'${MYSQL_USER_HOST}'=PASSWORD('${MYSQL_PASSWORD}');" >> /etc/mysql/docker-init-file.sql
    echo "UPDATE mysql.user SET plugin='' WHERE User='${MYSQL_USER}' AND Host='${MYSQL_USER_HOST}';" >> /etc/mysql/docker-init-file.sql
    echo "FLUSH PRIVILEGES;" >> /etc/mysql/docker-init-file.sql
fi
fi
fi

if [ -n "${MYSQL_USER}" ]; then
if [ -n "${MYSQL_PASSWORD}" ]; then
if [ -n "${MYSQL_DATABASE}" ]; then
if [ -f "/etc/mysql/docker-init-file.sql" ]; then
    echo "GRANT ALL ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'${MYSQL_USER_HOST}';" >> /etc/mysql/docker-init-file.sql
    echo "FLUSH PRIVILEGES;" >> /etc/mysql/docker-init-file.sql
fi
fi
fi
fi

unset MYSQL_PASSWORD

exit 0
