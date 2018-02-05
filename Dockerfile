FROM mback2k/debian:stretch

MAINTAINER Marc Hoersken "info@marc-hoersken.de"

RUN adduser --disabled-password --disabled-login --system --group \
        --uid 3306 --home /var/lib/mysql mysql

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        mariadb-client mariadb-server && \
    apt-get clean

RUN find /etc/mysql/ -name '*.cnf' -print0 \
    | xargs -0 grep -lZE '^(bind-address|log)' \
    | xargs -0 sed -Ei 's/^(bind-address|log)/#&/'
RUN echo '[mysqld]\nskip-host-cache\nskip-name-resolve' \
    > /etc/mysql/conf.d/docker.cnf

RUN mkdir -p /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

USER mysql
WORKDIR /var/lib/mysql

EXPOSE 3306

VOLUME /etc/mysql
VOLUME /var/lib/mysql

CMD ["/usr/sbin/mysqld"]
