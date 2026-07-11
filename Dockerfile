FROM ubuntu:22.04 AS builder

ARG DEBIAN_FRONTEND=noninteractive
ARG FALCO_VERSION=1.2.5

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    g++ \
    gcc \
    git \
    make \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /build
RUN git clone --depth 1 --branch v${FALCO_VERSION} https://github.com/smithlabcode/falco.git
WORKDIR /build/falco
RUN make CXXFLAGS="-O2 -std=c++17"

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    zlib1g \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/falco/bin/falco /usr/local/bin/falco

WORKDIR /data
ENTRYPOINT ["falco"]
