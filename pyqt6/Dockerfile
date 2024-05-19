FROM ben0i0d/jupyter:novnc

# Combine ENV statements
ENV LIBGL_ALWAYS_INDIRECT=1 \
    QT_DEBUG_PLUGINS=1 \
    QT_QUICK_BACKEND=software

USER root

# Install QT6 Dependencies
RUN apt-get update --yes  && apt-get install -y libgl1-mesa-dev libxkbcommon-x11-0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 \
    libxcb-xinerama0 libxcb-xinput0 libxcb-xfixes0 libxcb-shape0 libxcb-render0 libxcb-glx0 libxi6 libxkbfile1 libxcb-cursor0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  

USER $NB_USER

RUN pip install pyqt6 && \
    pip cache purge 