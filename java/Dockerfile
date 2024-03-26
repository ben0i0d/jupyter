FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

 

USER root
COPY ijava-1.3.0.zip ./ijava-kernel.zip
# Install dependencies
RUN apt update && apt install --yes --no-install-recommends openjdk-17-jdk && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  && \
    # Unpack and install the kernel
    unzip ijava-kernel.zip -d ijava-kernel  && \
    cd ijava-kernel  && \
    python3 install.py --sys-prefix && \
    rm ../ijava-kernel.zip

# Set user back to unpriviledged user.
USER  $NB_USER
