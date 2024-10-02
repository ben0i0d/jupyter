FROM eoelab.org:1027/ben0i0d/jupyter:py-c



USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-17-jre && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
USER $NB_UID

ENV JUPYTER_ENABLE_LAB=yes

RUN mamba install --yes -c jetbrains kotlin-jupyter-kernel && \
    mamba clean --all -f -y 
