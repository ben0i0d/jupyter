FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
# R pre-requisites
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends gfortran gcc fonts-dejavu && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${NB_UID}
# R packages including IRKernel which gets installed globally.
# base
RUN mamba install --yes \
    # base
    'r-base' 'r-irkernel' \
    # Interactivity and visualization
    'r-shiny' 'r-htmlwidgets' 'r-htmltools' 'r-crayon' \
    # Machine learning and data mining
    'r-caret' 'r-e1071' 'r-forecast' 'r-randomforest' 'r-tidymodels' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"