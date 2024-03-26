FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

 

USER root

WORKDIR /opt

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends make && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  && \
    git clone --depth=1 https://eoelab.org:1031/mirrored-sources/agda-kernel.git && cd agda-kernel && \
    pip install --no-cache-dir agda_kernel && \
    python -m agda_kernel.install && \
    make codemirror-install 

USER ${NB_UID}
WORKDIR "${HOME}"




