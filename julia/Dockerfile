FROM ben0i0d/jupyter:py-c

USER root

ENV JULIA_PKG_SERVER=https://mirrors.ustc.edu.cn/julia \
    JULIA_NUM_THREADS=12
# install Julia packages in /opt/julias
RUN apt-get update --yes && apt-get install --yes --no-install-recommends gnupg && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip --no-cache-dir install jill && jill install --confirm && \
    chown -hR "${NB_USER}:${NB_GID}" "/opt/julias"
    
USER ${NB_UID}
# Install IJulia as jovyan and then move the kernelspec out to the system share location. 
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"' && \
    mv "${HOME}/.local/share/jupyter/kernels/"* "/opt/base/share/jupyter/kernels/" && \
    rm -rf "${HOME}/.local" 