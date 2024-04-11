FROM debian:trixie-slim

EXPOSE 8888

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive \
    NB_USER=jovyan \
    NB_UID=1000 \
    NB_GID=100 \
    PATH="/opt/base/bin:${PATH}" \
    HOME="/home/jovyan"

# Copy files
COPY cert/cert.pem /usr/local/share/ca-certificates/eoelab.org.crt
COPY conf/pip.conf /etc/
COPY conf/fix-permissions start-sh/* /usr/local/bin/
COPY conf/jupyter_server_config.py /etc/jupyter/

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update --yes && apt-get install --yes --no-install-recommends sudo tini git zip unzip fonts-wqy-zenhei python3-pip python3-venv && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    chmod a+rx /usr/local/bin/* && \
    useradd -l -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" && \
    usermod -aG sudo "${NB_USER}" && echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  && \
    mkdir -p "/opt/base/" && python3 -m venv /opt/base && chown -hR "${NB_USER}:${NB_GID}" "/opt/base" && \
    chmod g+w /etc/passwd && \
    mkdir /usr/local/bin/start-notebook.d && mkdir /usr/local/bin/before-notebook.d 

USER ${NB_UID}

# install jupyter python mamba extension
RUN pip install 'jupyterlab' && \
    pip install jupyterlab-language-pack-zh-CN jupyterlab_tabnine && \
    pip cache purge 

WORKDIR "${HOME}"

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]