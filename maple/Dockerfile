FROM ben0i0d/jupyter:up-c

 

USER root

ENV PATH="${PATH}:/opt/maple/bin" 

COPY kernel/* /opt/conda/share/jupyter/kernels/maple/

RUN wget -q https://eoelab.org:1024/s/DDMg8r27Lr75sBo/download/Maple2023.0LinuxX64Installer.run && chmod +x Maple2023.0LinuxX64Installer.run && \
    ./Maple2023.0LinuxX64Installer.run --mode unattended --installer-language en --installdir /opt/maple --desktopshortcut 0 && rm Maple2023.0LinuxX64Installer.run && \
    fix-permissions /opt/maple && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions "${CONDA_DIR}"

USER ${NB_UID}