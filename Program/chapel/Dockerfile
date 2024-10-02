FROM eoelab.org:1027/ben0i0d/jupyter:py-c



WORKDIR /opt

COPY chapel-1.31.0.tar.gz ./

USER root

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}" \
    CHPL_LIB_PIC=shared 

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends gcc g++ m4 perl make mawk pkg-config cmake \
    llvm-dev llvm clang libclang-dev libclang-cpp-dev libedit-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    tar -xzf chapel-1.31.0.tar.gz && \
    cd chapel-1.31.0 && \
    source util/quickstart/setchplenv.bash && make && \
    pip install --no-cache-dir jupyter-kernel-chapel  

USER ${NB_UID}
WORKDIR "${HOME}"
