FROM ben0i0d/jupyter:py-c

USER root

ENV PATH="${PATH}:/opt/maple/bin" 

COPY --chown="${NB_UID}:${NB_GID}" kernel /opt/conda/share/jupyter/kernels/maple/
COPY Maple2023.0LinuxX64Installer.run .

RUN chmod +x Maple2023.0LinuxX64Installer.run && \
    ./Maple2023.0LinuxX64Installer.run --mode unattended --installer-language en --installdir /opt/maple --desktopshortcut 0 && rm Maple2023.0LinuxX64Installer.run 

USER ${NB_UID}