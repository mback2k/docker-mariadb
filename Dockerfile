ARG MARIADB_VERSION=10.1

FROM mariadb:${MARIADB_VERSION}

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb /opt/dumb-init_1.2.1_amd64.deb
RUN dpkg -i /opt/dumb-init_1.2.1_amd64.deb

RUN echo "#!/bin/sh" > /usr/local/sbin/mysqld; \
    echo "exec /usr/sbin/mysqld \$@" >> /usr/local/sbin/mysqld; \
    chown --reference=/usr/sbin/mysqld /usr/local/sbin/mysqld; \
    chmod --reference=/usr/sbin/mysqld /usr/local/sbin/mysqld;

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["mysqld"]
