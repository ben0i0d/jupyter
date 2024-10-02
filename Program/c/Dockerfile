FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

USER root

WORKDIR /opt

RUN apt-get update --yes && apt-get install --yes --no-install-recommends git && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    git clone --depth 1 https://eoelab.org:1027/mirrors/jupyter-c-kernel.git

FROM eoelab.org:1027/ben0i0d/jupyter:py-c

COPY --chown="${NB_UID}:${NB_GID}" --from=builder /opt/jupyter-c-kernel/ /opt/jupyter-c-kernel/

USER root

RUN apt-get update --yes && apt-get install --yes gcc && apt-get clean && rm -rf /var/lib/apt/lists/*  

USER ${NB_UID}

RUN cd /opt/jupyter-c-kernel && pip install -e . && \
    cd jupyter_c_kernel && install_c_kernel --sys-prefix
