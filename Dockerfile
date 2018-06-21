FROM mback2k/debian:stretch

RUN adduser --disabled-password --disabled-login --system --group \
        --uid 3306 --home /var/lib/mysql mysql

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        mariadb-server mariadb-client && \
    apt-get clean

EXPOSE 3306

RUN find /etc/mysql/ -name '*.cnf' -print0 \
    | xargs -0 grep -lZE '^(bind-address|log)' \
    | xargs -0 sed -Ei 's/^(bind-address|log)/#&/'
RUN echo '[mysqld]\nskip-host-cache\nskip-name-resolve' \
    > /etc/mysql/conf.d/docker.cnf

RUN mkdir -p /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

WORKDIR /var/lib
RUN tar cfvz mysql-content.tar.gz mysql

VOLUME /var/lib/mysql
USER mysql

ADD docker-entrypoint.d/ /run/docker-entrypoint.d/

CMD ["/usr/sbin/mysqld"]
