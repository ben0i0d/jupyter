FROM ben0i0d/jupyter:py-c

USER root

ENV MODULAR_HOME="/opt/modular" \
    PATH="$PATH:/opt/modular/pkg/packages.modular.com_mojo/bin"

RUN apt-get update && apt-get install --yes --no-install-recommends curl libedit2 && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/modular && \
    curl https://get.modular.com | MODULAR_AUTH=mut_631a7d7cd03d4185b786385c42384278 sh - && \
    modular auth mut_631a7d7cd03d4185b786385c42384278 && modular install mojo 
    
USER ${NB_UID}

RUN python /opt/modular/pkg/packages.modular.com_mojo/jupyter/manage_kernel.py install