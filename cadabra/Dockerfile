FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

WORKDIR /opt

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends cadabra2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${NB_UID}
WORKDIR "${HOME}"



