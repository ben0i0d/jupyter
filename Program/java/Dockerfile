FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

USER root

WORKDIR /opt

RUN apt-get update --yes && apt-get install --yes --no-install-recommends wget unzip && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget https://eoelab.org:1027/ben0i0d/sources/src/commit/e8631a5dce40bd0b134758f1aff4caca59c082fe/ijava-1.3.0.zip && \
    unzip ijava-1.3.0.zip -d IJava && rm ijava-1.3.0.zip

FROM eoelab.org:1027/ben0i0d/jupyter:py-c

COPY --chown="${NB_UID}:${NB_GID}" --from=builder /opt/IJava/ /opt/IJava/

USER root

# Install dependencies
RUN apt update && apt install --yes --no-install-recommends openjdk-17-jdk && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# install the kernel
USER $NB_USER
RUN cd /opt/IJava  && python3 install.py --sys-prefix