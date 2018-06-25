#!/bin/sh
set -e

if [ -z "${MYSQL_INITDB_SKIP_TZINFO}" ]; then
if [ -d "/usr/share/zoneinfo" -a -d "mysql/mysql" ]; then
    runuser -u mysql -- /bin/sh -c 'mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql_embedded mysql'
fi
fi

exit 0
