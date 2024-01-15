# syntax = docker/dockerfile:1

FROM debian:stable as base

RUN apt-get update && apt -y install \
    libaio-dev \
    default-libmysqlclient-dev libssl-dev \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/*


# Throw-away build stage to reduce size of final image
FROM base as build

RUN apt-get update && apt -y install \
    make automake libtool pkg-config && \
    rm -rf /var/lib/apt/lists/*

COPY --link . /sysbench
WORKDIR /sysbench
RUN ./autogen.sh && ./configure --with-mysql --with-pgsql && make -j


# Final stage for app image
FROM base

COPY --from=build /sysbench/src/sysbench /usr/bin/sysbench

CMD ["sysbench"]
