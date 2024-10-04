FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends cadabra2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${NB_UID}



