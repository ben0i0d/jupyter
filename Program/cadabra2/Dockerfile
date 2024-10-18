FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends cadabra2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mv /usr/share/jupyter/kernels/cadabra2/ /opt/base/share/jupyter/kernels/ && \
    sed -i 's/usr/opt\/base/g' /opt/base/share/jupyter/kernels/cadabra2/kernel.json && \
    chown -R ${NB_UID}:${NB_GID} /opt/base/share/jupyter/kernels/cadabra2

USER ${NB_UID}
