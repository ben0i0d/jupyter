FROM eoelab.org:1027/ben0i0d/jupyter:py-c



USER root

RUN apt-get update --yes && \
    apt-get install --yes nodejs npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  && \
    npm config set registry https://registry.npmmirror.com && \
    npm install -g --unsafe-perm ijavascript && \
    ijsinstall --install=global

USER ${NB_UID}


