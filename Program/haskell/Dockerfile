FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root

ENV STACK_ROOT=/opt/stack

# Stack switch to mirrored source
COPY stack.config.yaml /etc/stack/config.yaml
#COPY global-hints.yaml /etc/stack/global-hints-cache.yaml

# Install system dependencies
RUN apt-get update && apt-get install --yes haskell-stack git g++ && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt/stack && chown $NB_UID:$NB_GID /opt/stack
# Build IHaskell

USER $NB_UID


