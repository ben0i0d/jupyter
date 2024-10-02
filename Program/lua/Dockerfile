FROM eoelab.org:1027/ben0i0d/jupyter:py-c



USER root

WORKDIR /opt

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends lua5.4 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  && \
    pip install ilua

USER ${NB_UID}
WORKDIR "${HOME}"

