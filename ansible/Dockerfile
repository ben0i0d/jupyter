FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c


SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

WORKDIR /opt

RUN pip install ansible-kernel && \
    python -m ansible_kernel.install

USER ${NB_UID}
WORKDIR "${HOME}"
