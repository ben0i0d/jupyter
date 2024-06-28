FROM docker.io/ben0i0d/jupyter:py-c AS builder

COPY Maple2024.0LinuxX64Installer.run .

USER root
# Two RUN layer to use cache
RUN chmod +x Maple2024.0LinuxX64Installer.run && \
    ./Maple2024.0LinuxX64Installer.run --mode unattended --installer-language en --installdir /opt/maple --desktopshortcut 0 && rm Maple2024.0LinuxX64Installer.run

FROM docker.io/ben0i0d/jupyter:py-c

ENV PATH="${PATH}:/opt/maple/bin" 

COPY --chown="${NB_UID}:${NB_GID}" kernel /opt/base/share/jupyter/kernels/maple/
COPY --from=builder  /opt/maple /opt/maple