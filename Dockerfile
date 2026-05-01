# syntax=docker/dockerfile:1

FROM ubuntu:22.04 AS builder

ARG DEBIAN_FRONTEND=noninteractive
ARG FALCO_VERSION=v1.3.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget -O falco.tar.gz "https://github.com/smithlabcode/falco/releases/download/${FALCO_VERSION}/falco-${FALCO_VERSION#v}.tar.gz" \
    && tar -xzf falco.tar.gz \
    && cd "falco-${FALCO_VERSION#v}" \
    && ./configure CXXFLAGS='-O3 -Wall' \
    && make -j"$(nproc)" all \
    && make install

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/falco /usr/local/bin/falco

WORKDIR /data
ENTRYPOINT ["falco"]
CMD ["--help"]
