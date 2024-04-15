FROM ben0i0d/jupyter:py-c

USER root

ENV SCILAB_EXECUTABLE='scilab-cli'

#install scilab-cli
RUN apt-get update --yes && \
    apt-get install --yes scilab-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  

USER $NB_USER

RUN pip install scilab_kernel && \
    pip cache purge 