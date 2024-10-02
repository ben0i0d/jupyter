FROM eoelab.org:1027/ben0i0d/jupyter:py-c

# Extra arguments to `stack build`. Used to build --fast, see Makefile.
ARG STACK_ARGS=
ARG STACK_BINDIST="stack-2.11.1-linux-x86_64"



USER root

ENV PATH="/opt/bin:/opt/ghc/bin:${PATH}" \
    STACK_ROOT=/opt/stack

# Stack global non-project-specific config stack.config.yaml
# Stack global project stack.yaml
COPY stack.config.yaml /etc/stack/config.yaml
COPY global-hints.yaml /etc/stack/global-hints-cache.yaml
COPY stack-2.11.1-linux-x86_64.tar.gz /tmp/stack-2.11.1-linux-x86_64.tar.gz
COPY global-project.stack.yaml $STACK_ROOT/global-project/stack.yaml


RUN fix-permissions $STACK_ROOT && fix-permissions /etc/stack/ && \
# Install system dependencies
    apt-get update && apt-get install -yq --no-install-recommends python3-pip libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev \
    libmagic-dev libblas-dev liblapack-dev libffi-dev libgmp-dev gnupg netbase graphviz gnuplot-nox \
    g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev less && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
# Stack Linux (generic) Manual download
    cd /tmp  && tar zxf ${STACK_BINDIST}.tar.gz && cp ${STACK_BINDIST}/stack /usr/bin/stack  && \
    rm -rf ${STACK_BINDIST}.tar.gz ${STACK_BINDIST}  && \
    chown --recursive $NB_UID:users $STACK_ROOT/global-project && \
    fix-permissions $STACK_ROOT/global-project && \
# Clone IHaskell and install ghc from the IHaskell resolver
    cd /opt  && \
    curl -L "https://eoelab.org:1031/mirrored-sources/IHaskell/-/archive/master/IHaskell-master.tar.gz" | tar xzf - && mv *IHaskell* IHaskell && \
    curl -L "https://eoelab.org:1031/mirrored-sources/hvega/-/archive/main/hvega-main.tar.gz" | tar xzf -  && mv *hvega* hvega  && \
    fix-permissions /opt/IHaskell  && \
    fix-permissions $STACK_ROOT  && \
    fix-permissions /opt/hvega  && \
    mkdir -p $HOME/.cabal && \
    echo "repository mirrors.ustc.edu.cn\n  url: https://mirrors.ustc.edu.cn/hackage/\n  secure: True" > $HOME/.cabal/config && \
    stack setup  && \
    fix-permissions $STACK_ROOT  && \
    rm /opt/stack/programs/x86_64-linux/ghc*.tar.xz && \
# Build IHaskell
# Note that we are NOT in the /opt/IHaskell directory here, we are installing ihaskell via the paths given in /opt/stack/global-project/stack.yaml
    stack build $STACK_ARGS ihaskell  && \
    fix-permissions /opt/IHaskell  && \
    fix-permissions $STACK_ROOT  && \
# Install IHaskell.Display libraries
    stack build $STACK_ARGS ihaskell-charts  && \
    stack build $STACK_ARGS ihaskell-widgets  && \
    stack build $STACK_ARGS hvega  && \
    stack build $STACK_ARGS ihaskell-hvega  && \
    fix-permissions $STACK_ROOT  && \
# Fix for https://github.com/IHaskell/ihaskell-notebook/issues/14#issuecomment-636334824
    fix-permissions /opt/IHaskell  && \
    fix-permissions /opt/hvega && \
# Install system-level ghc using the ghc which was installed by stack.using the IHaskell resolver.
    mkdir -p /opt/ghc && ln -s `stack path --compiler-bin` /opt/ghc/bin  && \
    fix-permissions /opt/ghc && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Switch back to jovyan user
USER $NB_UID
RUN stack exec ihaskell -- install --stack --prefix=/opt/conda/


