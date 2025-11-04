FROM postgres:17-alpine

RUN apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    make \
    postgresql-dev \
    clang19 \
    llvm19 \
    git

RUN ln -s /usr/bin/clang-19 /usr/bin/clang && ln -s /usr/bin/clang++-19 /usr/bin/clang++

# install pg_partman
RUN git clone https://github.com/pgpartman/pg_partman.git /tmp/pg_partman && \
    cd /tmp/pg_partman && \
    make && \
    make install

RUN apk del .build-deps && \
    rm -rf /tmp/pg_partman

RUN echo "shared_preload_libraries = 'pg_stat_statements,pg_partman_bgw''" >> /usr/local/share/postgresql/postgresql.conf.sample

RUN echo "pg_partman_bgw.interval = 3600" >> /usr/local/share/postgresql/postgresql.conf.sample && \
    echo "pg_partman_bgw.role = 'postgres'" >> /usr/local/share/postgresql/postgresql.conf.sample && \
    echo "pg_partman_bgw.dbname = 'postgres'" >> /usr/local/share/postgresql/postgresql.conf.sample

RUN mkdir -p /docker-entrypoint-initdb.d

EXPOSE 5432
