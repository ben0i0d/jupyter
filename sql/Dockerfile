FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

 

RUN pip install duckdb duckdb_kernel && \
    pip cache purge && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"