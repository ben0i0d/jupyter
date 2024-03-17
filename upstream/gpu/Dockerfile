FROM eoelab.org:1032/build-image-stacks/nvidia-cuda-image/cuda:12.2.0-devel-debian13

EXPOSE 8888

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive \
    CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    NB_USER=jovyan \
    NB_UID=1000 \
    NB_GID=100 \
    LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    PATH="/opt/conda/bin:${PATH}" \
    HOME="/home/jovyan"

# Copy files
COPY cert/cert.pem /usr/local/share/ca-certificates/eoelab.org.crt
COPY conf/fix-permissions start-sh/* /usr/local/bin/
COPY conf/jupyter_server_config.py /etc/jupyter/
COPY conf/initial-condarc "${CONDA_DIR}/.condarc"
COPY conf/Rprofile.site /opt/conda/lib/R/etc/
# Prevent the PATH variable from being overwritten
COPY conf/profile /etc/profile

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update --yes && apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends zsh sudo ca-certificates gnupg2 locales tini wget curl git git-lfs vim bzip2 zip unzip xclip p7zip-full fonts-wqy-zenhei && \
    update-ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "zh_CN.UTF-8 UTF-8">/etc/locale.gen && locale-gen && \
    chmod a+rx /usr/local/bin/* && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd -l -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" && \
    usermod -aG sudo "${NB_USER}" && echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  && \
    mkdir -p "${CONDA_DIR}" && chown "${NB_USER}:${NB_GID}" "${CONDA_DIR}" && \
    chmod g+w /etc/passwd && \
    mkdir /usr/local/bin/start-notebook.d && mkdir /usr/local/bin/before-notebook.d && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions "${CONDA_DIR}"

USER ${NB_UID}

WORKDIR /tmp
# install jupyter python mamba extension
RUN wget -qO /tmp/micromamba.tar.bz2 "https://micromamba.snakepit.net/api/micromamba/linux-64/latest" && \
    tar -xvjf /tmp/micromamba.tar.bz2 --strip-components=1 bin/micromamba && rm /tmp/micromamba.tar.bz2 && \
    ./micromamba install --root-prefix="${CONDA_DIR}" --prefix="${CONDA_DIR}" --yes 'mamba' "python=3.11" 'jupyter_core' 'jupyterlab' 'jupyterhub' 'notebook' && \
    rm micromamba && \
    mamba list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "${CONDA_DIR}/conda-meta/pinned" && \
    mamba clean --all -f -y && \
    pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple && \
    pip install jupyterlab-language-pack-zh-CN jupyterlab_tabnine && \
    pip cache purge && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" 

WORKDIR "${HOME}"

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]