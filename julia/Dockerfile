FROM ben0i0d/jupyter:py-c

USER root

# install Julia packages in /opt/julia
ENV JULIA_DEPOT_PATH=/opt/julia \
    JULIA_PKG_SERVER=https://mirrors.ustc.edu.cn/julia \
    JULIA_NUM_THREADS=12

RUN apt-get update --yes && apt-get install --yes --no-install-recommends gnupg && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip install jill && jill install --confirm

USER ${NB_UID}
# Add Julia packages.
# Install IJulia as jovyan and then move the kernelspec out to the system share location. 
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"' && \
    mv "${HOME}/.local/share/jupyter/kernels/julia"* "/opt/base/share/jupyter/kernels/" && \
    chmod -R go+rx "/opt/base//share/jupyter" && \
    rm -rf "${HOME}/.local" 

