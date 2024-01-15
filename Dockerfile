# syntax = docker/dockerfile:1

FROM debian:stable

RUN apt-get update && apt -y install \
    make automake libtool pkg-config libaio-dev \
    default-libmysqlclient-dev libssl-dev \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --link . /sysbench
WORKDIR /sysbench
RUN ./autogen.sh && ./configure --with-mysql --with-pgsql && make -j && make install

ENV PATH="${PATH}:/sysbench/src"

CMD ["sysbench"]
