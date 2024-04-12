FROM ben0i0d/jupyter:py-c

USER root

# Sage pre-requisites and jq for manipulating json
RUN apt-get update && \
    apt-get install -y --no-install-recommends sagemath sagemath-jupyter sagemath-doc && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID


