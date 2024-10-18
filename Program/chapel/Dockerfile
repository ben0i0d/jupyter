FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

USER root

WORKDIR /opt

RUN apt-get update --yes && apt-get install --yes --no-install-recommends wget && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget https://eoelab.org:1027/ben0i0d/sources/raw/branch/main/chapel-2.2.0-1.debian12.amd64.deb


FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root

COPY --from=builder /opt/chapel-2.2.0-1.debian12.amd64.deb /tmp/chapel-2.2.0-1.debian12.amd64.deb

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends /tmp/chapel-2.2.0-1.debian12.amd64.deb && rm /tmp/chapel-2.2.0-1.debian12.amd64.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

RUN pip install jupyter-kernel-chapel && \
    pip cache purge