FROM ben0i0d/jupyter:py-c

USER root
# Install Octave + package + graph_toolkit
RUN apt-get update --yes && \
    apt-get install --yes octave octave-image gnuplot && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${NB_UID}

# Install Octave kernel
RUN pip install octave_kernel && \
    pip cache purge 
