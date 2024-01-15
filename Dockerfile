# syntax = docker/dockerfile:1

FROM debian:stable

RUN curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | bash
RUN apt update && apt -y install sysbench && \
    rm -rf /var/lib/apt/lists/*

CMD ["sysbench"]
