FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

ENV MODULAR_HOME="/opt/modular" \
    PATH="$PATH:/opt/modular/pkg/packages.modular.com_mojo/bin"

RUN mkdir /opt/modular && \
    curl https://get.modular.com | MODULAR_AUTH=mut_631a7d7cd03d4185b786385c42384278 sh - && \
    apt install -y libedit2 && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    modular auth mut_631a7d7cd03d4185b786385c42384278 && modular install mojo && \
    fix-permissions /opt/modular && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions "${CONDA_DIR}"
    
USER ${NB_UID}