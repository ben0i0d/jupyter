FROM docker.io/ben0i0d/jupyter:py-c

USER root

RUN apt-get update --yes && \
    apt-get --yes install --yes --no-install-recommends dbus-x11 xfce4 xfce4-panel xfce4-session xfce4-settings xorg tigervnc-standalone-server tigervnc-xorg-extension websockify  && \ 
    apt-get clean && rm -rf /var/lib/apt/lists/*  

USER $NB_USER

RUN pip install jupyter-remote-desktop-proxy && \
    pip cache purge 