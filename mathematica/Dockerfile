FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

ENV PATH="${PATH}:/opt/Wolfram/Mathematica/13.3/Executables/" 

COPY kernel/* /opt/conda/share/jupyter/kernels/Mathematica13.3/

RUN wget -q https://eoelab.org:1024/s/wfpT4Sg7dttYo5o/download/Mathematica_13.3.1_LINUX_CN.sh && \
    bash Mathematica_13.3.1_LINUX_CN.sh -- -auto -targetdir=/opt/Wolfram/Mathematica/13.3 && rm Mathematica_13.3.1_LINUX_CN.sh && \
    git clone --depth=1 https://eoelab.org:1031/mirrored-sources/WolframLanguageForJupyter.git && mv WolframLanguageForJupyter /opt && \
    fix-permissions /opt/Wolfram/ && \
    fix-permissions /opt/WolframLanguageForJupyter && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions "${CONDA_DIR}"

USER ${NB_UID}