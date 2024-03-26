FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

 

USER root
# Install fortran kernel
RUN mamba install --yes -c conda-forge lfortran && \
    mamba clean --all -f -y  && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}
