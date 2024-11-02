FROM eoelab.org:1027/ben0i0d/jupyter:py-c

ARG CRAN_MIRROR

USER root

# INSTALL R+IRkernel & languageserver
RUN apt-get update && apt-get install --yes --no-install-recommends r-base r-cran-irkernel && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    # set cran mirror
    echo "options(repos=c(${CRAN_MIRROR}))" >> /usr/lib/R/library/base/R/Rprofile && \
    # Install IRkernel
    R -e 'IRkernel::installspec(sys_prefix = TRUE);q()' && \
    # Install languageserver
    R -e 'install.packages("languageserver");q()'&& \
    chown -hR "${NB_USER}:${NB_GID}" "${HOME}"

USER ${NB_UID}