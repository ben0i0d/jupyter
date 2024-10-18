FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

ENV MAMBA_ROOT_PREFIX=/opt/mamba

COPY .condarc /opt/mamba/.condarc

USER root

RUN apt-get update --yes && apt-get install --yes wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget https://eoelab.org:1027/ben0i0d/sources/raw/branch/main/micromamba && \
    chmod +x micromamba && \
    ./micromamba install --yes --root-prefix /opt/mamba lfortran -c conda-forge && \
    ./micromamba clean --yes --all


FROM eoelab.org:1027/ben0i0d/jupyter:py-c

COPY --chown="${NB_UID}:${NB_GID}" --from=builder /opt/mamba /opt/mamba

ENV PATH="/opt/mamba/bin:${PATH}"

USER ${NB_UID}

RUN mv /opt/mamba/share/jupyter/kernels/fortran/ /opt/base/share/jupyter/kernels/