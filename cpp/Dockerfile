FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

 

USER root

RUN apt-get update --yes && \
    apt-get install --yes g++ && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${NB_UID}

# Install Cpp kernel
RUN mamba install --yes -c conda-forge xeus-cling && \
    mamba clean --all -f -y 
