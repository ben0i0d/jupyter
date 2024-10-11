FROM debian:bookworm-slim

EXPOSE 8888

USER root

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive \
    NB_USER=jovyan \
    NB_UID=1000 \
    NB_GID=100 \
    PATH="/opt/base/bin:${PATH}" \
    HOME="/home/jovyan"

# Copy files
COPY start-sh/* /usr/local/bin/

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    # install base packages
    apt-get update --yes && apt-get install --yes --no-install-recommends sudo tini unzip python3-venv && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    chmod a+rx /usr/local/bin/* && \
    # Create user , set password and add to sudoers
    useradd -l -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" && \
    usermod -aG sudo "${NB_USER}" && echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  && \
    chmod g+w /etc/passwd && \
    # Create dirs for startup hooks
    mkdir /usr/local/bin/start-notebook.d && mkdir /usr/local/bin/before-notebook.d && \
    # setup base venv & pip_mirror
    mkdir -p "/opt/base/" && python3 -m venv /opt/base && chown -hR "${NB_USER}:${NB_GID}" "/opt/base" && \
    echo '[global]\nindex-url = https://mirrors.bfsu.edu.cn/pypi/web/simple' >  /etc/pip.conf

USER ${NB_UID}

# install jupyter extension
RUN pip install 'jupyterlab' 'jupyterhub' && \
    pip install jupyterlab-language-pack-zh-CN jupyterlab_tabnine && \
    pip cache purge 

WORKDIR "${HOME}"

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]