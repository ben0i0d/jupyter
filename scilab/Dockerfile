FROM ben0i0d/jupyter:up-c

 

USER root

ENV SCILAB_EXECUTABLE='scilab-cli'

#install desktop+scilab+extension
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
        dbus-x11 xfce4 xfce4-panel xfce4-session xfce4-settings xorg tigervnc-standalone-server tigervnc-xorg-extension \
        scilab scilab-* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions "${CONDA_DIR}"

USER $NB_USER

RUN pip install websockify jupyter-remote-desktop-proxy scilab_kernel && \
    pip cache purge 
    