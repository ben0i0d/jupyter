FROM ben0i0d/jupyter:py-c

USER root
# Install Octave + doc + package + graph_toolkit
RUN apt-get update --yes && \
    apt-get install --yes octave octave-doc octave-* gnuplot && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${NB_UID}

# Install Octave kernel
RUN mamba install --yes -c conda-forge octave_kernel && \
    mamba clean --all -f -y 
