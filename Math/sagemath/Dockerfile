FROM eoelab.org:1027/ben0i0d/jupyter:py-c

ENV BASE_DIR=/opt/base

USER root

# Sage install
RUN apt-get update && \
    apt-get install -y --no-install-recommends sagemath && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    sage -c 'from sage.repl.ipython_kernel.install import SageKernelSpec; SageKernelSpec.update(prefix=os.environ["BASE_DIR"])'

USER $NB_UID


