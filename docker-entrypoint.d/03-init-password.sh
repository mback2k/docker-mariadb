#!/bin/sh
set -e

if [ -f "${MYSQL_ROOT_PASSWORD_FILE}" ]; then
    MYSQL_ROOT_PASSWORD="$(< "${MYSQL_ROOT_PASSWORD_FILE}")"
fi

if [ -n "${MYSQL_ROOT_PASSWORD}" ]; then
if [ -f "/etc/mysql/debian.cnf" ]; then
    sed -i "s/password =/password = ${MYSQL_ROOT_PASSWORD}/g" /etc/mysql/debian.cnf
fi
fi

if [ -n "${MYSQL_ROOT_PASSWORD}" ]; then
if [ -f "/etc/mysql/docker-init-file.sql" ]; then
    echo "CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> /etc/mysql/docker-init-file.sql
    echo "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}');" >> /etc/mysql/docker-init-file.sql
    echo "UPDATE mysql.user SET plugin='' WHERE User='root' AND Host='localhost';" >> /etc/mysql/docker-init-file.sql
    echo "GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> /etc/mysql/docker-init-file.sql
    echo "FLUSH PRIVILEGES;" >> /etc/mysql/docker-init-file.sql
fi
fi

if [ -n "${MYSQL_ROOT_PASSWORD}" ]; then
if [ -n "${MYSQL_ROOT_HOST}" -a "${MYSQL_ROOT_HOST}" != 'localhost' ]; then
if [ -f "/etc/mysql/docker-init-file.sql" ]; then
    echo "CREATE USER IF NOT EXISTS 'root'@'${MYSQL_ROOT_HOST}' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> /etc/mysql/docker-init-file.sql
    echo "SET PASSWORD FOR 'root'@'${MYSQL_ROOT_HOST}'=PASSWORD('${MYSQL_ROOT_PASSWORD}');" >> /etc/mysql/docker-init-file.sql
    echo "UPDATE mysql.user SET plugin='' WHERE User='root' AND Host='${MYSQL_ROOT_HOST}';" >> /etc/mysql/docker-init-file.sql
    echo "GRANT ALL ON *.* TO 'root'@'${MYSQL_ROOT_HOST}' WITH GRANT OPTION;" >> /etc/mysql/docker-init-file.sql
    echo "FLUSH PRIVILEGES;" >> /etc/mysql/docker-init-file.sql
fi
fi
fi

unset MYSQL_ROOT_PASSWORD

exit 0
