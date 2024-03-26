FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:up-c

 

USER root

COPY conf/dep.txt /tmp/dep.txt
COPY conf/mpm_input_r2023b.txt /opt/mpm_input_r2023b.txt

# base deps,copy by mathworks-ref-arch/container-images
RUN apt-get update && apt-get install --no-install-recommends -y `cat /tmp/dep.txt` && \
# using Simulink code generation capabilities, compile mex files with gcc, g++, or gfortran.
    apt-get install -y gcc g++ gfortran \
# mathworks/jupyter-matlab-proxy require X Virtual Frame Buffer (Xvfb)
        xvfb \
# enable running a program that makes use of MATLAB's Engine API for C and Fortran
        csh && \
# enable the playing of media files (mp3, mp4, etc.) from within MATLAB.
    apt-get install --no-install-recommends -y libgstreamer1.0-0 gstreamer1.0-tools gstreamer1.0-libav gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly && \
# resolve any license manager issues
    ln -s /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3 && rm /tmp/dep.txt && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
# Run mpm to install MATLAB in the target location and delete the mpm installation afterwards.
    wget -q https://www.mathworks.com/mpm/glnxa64/mpm && chmod +x mpm && mv mpm /usr/local/bin/ && \
    mpm install --inputfile /opt/mpm_input_r2023b.txt && \
    ln -s /opt/matlab/r2023b/bin/matlab /usr/local/bin/matlab && \
# create license folder into the container. 
    mkdir -p /opt/matlab/r2023b/licenses/ && mkdir -p /opt/matlab/r2023b/bin/glnxa64/matlab_startup_plugins/lmgrimpl/ && \
# install matlab kernel
    pip install jupyter-matlab-proxy && \
    fix-permissions /opt/matlab && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}