FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root
# Install fortran kernel
RUN mamba install --yes -c conda-forge lfortran && \
    mamba clean --all -f -y  && \

USER ${NB_UID}
