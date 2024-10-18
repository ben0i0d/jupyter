FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root

ENV CARGO_HOME=/opt/rust/.cargo \
    RUSTUP_HOME=/opt/rust/.rust \
    PATH="$PATH:/opt/rust/.cargo/bin" \
    CARGO_HTTP_MULTIPLEXING=false

RUN mkdir -p /opt/rust/.cargo /opt/rust/.rust && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

COPY config /opt/rust/.cargo/config

RUN bash /opt/rust/rustup-init.sh -y && \
    cargo install evcxr_jupyter && \
    evcxr_jupyter --install && \
    rm /opt/rust/rustup-init.sh && \
    mv $HOME/.local/share/jupyter/kernels/rust /opt/base/share/jupyter/kernels/

USER $NB_USER