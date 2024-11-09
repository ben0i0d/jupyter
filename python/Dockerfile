FROM debian:bookworm-slim

ARG PYPI_MIRROR
ARG DEBIAN_MIRROR

EXPOSE 8888

USER root

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive \
    NB_USER=jovyan \
    NB_UID=1000 \
    NB_GID=100 \
    SHELL=/bin/bash \
    PATH="/opt/base/bin:${PATH}" \
    HOME="/home/jovyan" 

# start script
COPY start-sh/* /usr/local/bin/
# jupyter config (to disable hide files) & healthcheck script
COPY jupyter_server_config.py docker_healthcheck.py /etc/jupyter/
# shell profile , to disable PATH be overwrited by jupyter
COPY profile /etc/

RUN sed -i "s/deb.debian.org/${DEBIAN_MIRROR}/g" /etc/apt/sources.list.d/debian.sources && \
    # install base packages
    apt-get update --yes && apt-get install --yes --no-install-recommends sudo tini unzip python3-venv && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    # enhance scripts & repair HEALTHCHECK permission denied
    chmod a+rx /usr/local/bin/* /etc/jupyter/docker_healthcheck.py  && \
    # disable super permision
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    # Create user , set password and add to sudoers
    useradd --no-log-init --create-home --shell /bin/bash --uid "${NB_UID}" --no-user-group "${NB_USER}" && \
    echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  && \
    chmod g+w /etc/passwd && \
    # Create dirs for startup hooks
    mkdir /usr/local/bin/start-notebook.d && mkdir /usr/local/bin/before-notebook.d && \
    # setup base venv & pip_mirror
    mkdir -p "/opt/base/" && python3 -m venv /opt/base && chown -hR "${NB_USER}:${NB_GID}" "/opt/base" && \
    echo "[global]\nindex-url = ${PYPI_MIRROR}" >  /etc/pip.conf

# HEALTHCHECK documentation: https://docs.docker.com/engine/reference/builder/#healthcheck
# This healtcheck works well for `lab`, `notebook`, `nbclassic`, `server`, and `retro` jupyter commands
# https://github.com/jupyter/docker-stacks/issues/915#issuecomment-1068528799
HEALTHCHECK --interval=3s --timeout=1s --start-period=3s --retries=3 \
    CMD /etc/jupyter/docker_healthcheck.py || exit 1

USER ${NB_UID}

# install jupyterlab jupyterhub  extension python-lsp
RUN pip install 'jupyterlab' 'jupyterhub' && \
    pip install jupyterlab-language-pack-zh-CN jupyterlab-lsp jupyterlab-execute-time jedi-language-server && \
    pip cache purge 

WORKDIR "${HOME}"

# Configure container startup
ENTRYPOINT ["tini", "-g", "--", "start.sh"]
CMD ["start-notebook.py"]