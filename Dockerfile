FROM mback2k/debian:stretch

RUN adduser --disabled-password --disabled-login --system --group \
        --uid 3306 --home /var/lib/mysql mysql

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        mariadb-server mariadb-client && \
    apt-get install -y --no-install-recommends \
        rsync grep && \
    apt-get clean

EXPOSE 3306

RUN find /etc/mysql/ -name '*.cnf' -print0 \
    | xargs -0 grep -lZE '^(bind-address|log)' \
    | xargs -0 sed -Ei 's/^(bind-address|log)/#&/'

RUN mkdir -p /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

WORKDIR /var/lib

RUN tar cfvz mysql-content.tar.gz mysql
RUN chmod 640 mysql-content.tar.gz

VOLUME /var/lib/mysql

ADD docker-mysqld.cnf /etc/mysql/conf.d/docker-mysqld.cnf
ADD docker-galera-state.sh /usr/local/bin/docker-galera-state.sh

RUN chown mysql:mysql /usr/local/bin/docker-galera-state.sh
RUN chmod 700 /usr/local/bin/docker-galera-state.sh

ENV MYSQL_ROOT_HOST %
ENV MYSQL_USER_HOST %

ADD docker-entrypoint.d/ /run/docker-entrypoint.d/

CMD ["/usr/sbin/mysqld", "--user=mysql"]

HEALTHCHECK CMD grep -e '^Synced$' /var/lib/mysql/docker-galera.state || exit 1
