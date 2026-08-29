# syntax=docker/dockerfile:1

FROM ubuntu:22.04 AS builder

ARG DEBIAN_FRONTEND=noninteractive
ARG FALCO_VERSION=v2.0.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN curl -fsSL -o falco.tar.gz "https://github.com/smithlabcode/falco/releases/download/${FALCO_VERSION}/falco-${FALCO_VERSION#v}-Linux.tar.gz" \
    && tar -xzf falco.tar.gz \
    && mv "falco-${FALCO_VERSION#v}-Linux" /opt/falco

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/falco /opt/falco
ENV PATH="/opt/falco/bin:${PATH}"

WORKDIR /data
ENTRYPOINT ["falco"]
CMD ["--help"]
