FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

USER root

COPY .condarc /root/.condarc

RUN apt-get update --yes && apt-get install --yes wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget https://eoelab.org:1027/ben0i0d/sources/raw/commit/ebbcba790d7b1804efde0715592a0665f6b81fbd/micromamba && \
    chmod +x micromamba && ./micromamba install --yes --root-prefix /opt/mamba xeus-cling -c conda-forge

FROM eoelab.org:1027/ben0i0d/jupyter:py-c

COPY --chown="${NB_UID}:${NB_GID}" --from=builder /opt/mamba /opt/mamba

RUN jupyter kernelspec install /opt/mamba/share/jupyter/kernels/xcpp11 --sys-prefix && \
    jupyter kernelspec install /opt/mamba/share/jupyter/kernels/xcpp11 --sys-prefix && \
    jupyter kernelspec install /opt/mamba/share/jupyter/kernels/xcpp11 --sys-prefix