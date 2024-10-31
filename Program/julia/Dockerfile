FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

USER root

# install Julia packages in /opt/julias
RUN apt-get update --yes && apt-get install --yes --no-install-recommends gnupg && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip install jill && jill install --confirm 
    
FROM eoelab.org:1027/ben0i0d/jupyter:py-c 

ARG JULIA_MIRROR

COPY --chown="${NB_UID}:${NB_GID}" --from=builder /opt/julias/ /opt/julias/

ENV JULIA_PKG_SERVER=${JULIA_MIRROR} \
    JULIA_NUM_THREADS=8 \
    JUPYTER_DATA_DIR=/opt/base/share/jupyter \
    JULIA_DEPOT_PATH=/opt/julia \
    JULIA_PKGDIR=/opt/julia
    
USER root

RUN ln -s "`find /opt/julias -name 'bin'`/julia" /usr/local/bin/julia && \
    mkdir -p /opt/julia && chown -R ${NB_UID}:${NB_GID} /opt/julia

USER ${NB_UID}

# Install IJulia as jovyan
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"' 