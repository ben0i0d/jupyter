FROM eoelab.org:1027/ben0i0d/jupyter:py-c 
# AS builder

USER root

WORKDIR /opt

ENV STACK_ROOT=/opt/stack

# Stack switch to mirrored source
COPY config.yaml /etc/stack/config.yaml

# Install system dependencies
RUN apt-get update && apt-get install --yes haskell-stack git g++ wget libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget -O /etc/stack/global-hints-cache.yaml https://mirrors.ustc.edu.cn/stackage/stackage-content/stack/global-hints.yaml && \
    mkdir -p /opt/stack && \
    git clone --depth 1 https://eoelab.org:1027/mirrors/IHaskell.git && \
    cd IHaskell && sed -i 's/github.com\/codedownio/eoelab.org:1027\/mirrors/g' stack.yaml
    # Build IHaskell
#    stack install --fast --local-bin-path=/usr/local/bin

USER ${NB_UID}

# FROM eoelab.org:1027/ben0i0d/jupyter:py-c

# USER root

# ENV STACK_ROOT=/opt/stack

# # Stack switch to mirrored source
# COPY config.yaml /etc/stack/config.yaml

# COPY --from=builder /usr/local/bin/ihaskell /usr/local/bin/ihaskell
# COPY --chown="${NB_UID}:${NB_GID}" --from=builder /opt/stack/ /opt/stack/

# RUN apt-get update --yes && apt-get install --yes --no-install-recommends haskell-stack && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*  

# USER ${NB_UID}

# RUN ihaskell install --stack --prefix=/opt/base