FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
ENV CARGO_HOME=/opt/rust/.cargo \
    RUSTUP_HOME=/opt/rust/.rust \
    PATH=$PATH:/opt/rust/.cargo/bin \
    CARGO_HTTP_MULTIPLEXING=false

RUN mkdir -p /opt/rust/.cargo /opt/rust/.rust && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

COPY rustup-init.sh /opt/rust/rustup-init.sh
COPY config /opt/rust/.cargo/config

RUN bash /opt/rust/rustup-init.sh -y && \
    cargo install evcxr_jupyter && \
    evcxr_jupyter --install && \
    rm /opt/rust/rustup-init.sh && \
    cp -r $HOME/.local/share/jupyter/kernels/rust /opt/conda/share/jupyter/kernels/ && \
    rustup component add rust-src && \
    fix-permissions /opt/rust && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
    
USER $NB_USER