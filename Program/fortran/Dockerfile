FROM eoelab.org:1027/ben0i0d/jupyter:py-c



USER root
# Install fortran kernel
RUN mamba install --yes -c conda-forge lfortran && \
    mamba clean --all -f -y  && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}
