FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root

RUN apt-get update && \
    apt-get install --yes --no-install-recommends openjdk-17-jre && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN pip install kotlin-jupyter-kernel && \
    pip cache purge
