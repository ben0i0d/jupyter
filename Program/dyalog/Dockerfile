FROM eoelab.org:1027/ben0i0d/jupyter:py-c



USER root

WORKDIR /opt

COPY linux_64_18.2.45405_unicode.x86_64.deb ./

RUN dpkg -i linux_64_18.2.45405_unicode.x86_64.deb && \
    rm linux_64_18.2.45405_unicode.x86_64.deb && \
    pip install dyalog-jupyter-kernel

USER ${NB_UID}
WORKDIR "${HOME}"


