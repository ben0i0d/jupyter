FROM docker.io/ben0i0d/jupyter:py-c

USER root

# INSTALL R+IRkernel
RUN apt-get update && apt-get install --yes --no-install-recommends r-base r-cran-irkernel && apt-get clean && rm -rf /var/lib/apt/lists/* && \
# set cran mirror    
    echo 'options(repos=c(USTC="https://mirrors.ustc.edu.cn/CRAN/"))' >> /usr/lib/R/library/base/R/Rprofile && \
    R -e 'IRkernel::installspec(sys_prefix = TRUE);q()' && \
    chown -hR "${NB_USER}:${NB_GID}" "${HOME}"

USER ${NB_UID}