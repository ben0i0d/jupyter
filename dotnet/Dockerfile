FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
# Install Dotnet SDK+Runtime + kernel
ENV PATH ${PATH}:/opt/dotnet/tools
RUN mkdir -p /opt/dotnet/tools && \
    wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    sudo dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && \
    apt-get update && apt-get install -y --no-install-recommends dotnet-sdk-7.0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    dotnet tool install Microsoft.dotnet-interactive --tool-path /opt/dotnet/tools && \
    dotnet interactive jupyter install && \
    fix-permissions /opt/dotnet && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER $NB_USER
