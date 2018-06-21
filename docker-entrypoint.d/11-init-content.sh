#!/bin/sh
set -e

if [ ! -d "mysql/mysql" ]; then
    tar xfvz mysql-content.tar.gz
fi

exit 0
