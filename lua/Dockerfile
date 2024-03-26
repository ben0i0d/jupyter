FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

 

USER root

WORKDIR /opt

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends lua5.4 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  && \
    pip install ilua

USER ${NB_UID}
WORKDIR "${HOME}"

