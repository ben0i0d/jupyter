FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

USER root

WORKDIR /opt

RUN apt-get update --yes && apt-get install --yes --no-install-recommends git && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    git clone --depth 1 https://eoelab.org:1027/mirrors/gophernotes.git
    


FROM eoelab.org:1027/ben0i0d/jupyter:py-c

COPY --chown="${NB_UID}:${NB_GID}" --from=builder /opt/gophernotes /opt/gophernotes

USER root

# Install system dependencies
RUN apt-get update && apt-get install --yes --no-install-recommends golang gcc libc6-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt/go && chown -R "${NB_UID}:${NB_GID}" /opt/go
    
USER $NB_USER
    
RUN go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct && \
    go env -w GOPATH=/opt/go && \
    cd /opt/gophernotes && go install && \
    mkdir -p /opt/base/share/jupyter/kernels/gophernotes && cp kernel/* /opt/base/share/jupyter/kernels/gophernotes && \
    # in case copied kernel.json has no write permission
    cd /opt/base/share/jupyter/kernels/gophernotes/ && chmod +w kernel.json && \
    sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json
    
