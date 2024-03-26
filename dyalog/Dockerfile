FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

 

USER root

WORKDIR /opt

COPY linux_64_18.2.45405_unicode.x86_64.deb ./

RUN dpkg -i linux_64_18.2.45405_unicode.x86_64.deb && \
    rm linux_64_18.2.45405_unicode.x86_64.deb && \
    pip install dyalog-jupyter-kernel

USER ${NB_UID}
WORKDIR "${HOME}"


