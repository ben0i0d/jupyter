FROM docker.io/ben0i0d/jupyter:py-c AS builder

USER root

# install Julia packages in /opt/julias
RUN apt-get update --yes && apt-get install --yes --no-install-recommends gnupg && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip --no-cache-dir install jill && jill install --confirm 

FROM docker.io/ben0i0d/jupyter:py-c 

COPY --chown="${NB_UID}:${NB_GID}" --from=builder /opt/julias/ /opt/julias/

ENV JULIA_PKG_SERVER=https://mirrors.cernet.edu.cn/julia \
    JULIA_NUM_THREADS=12

USER root

RUN ln -s "`find /opt/julias -name 'bin'`/julia" /usr/local/bin/julia 

USER ${NB_UID}
# Install IJulia as jovyan and then move the kernelspec out to the system share location. 
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"' && \
    mv "${HOME}/.local/share/jupyter/kernels/"* "/opt/base/share/jupyter/kernels/" && \
    rm -rf "${HOME}/.local" 