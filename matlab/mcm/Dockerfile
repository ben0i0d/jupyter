FROM docker.io/ben0i0d/jupyter:matlab-minimal

USER root

COPY conf/mpm_input_r2023b.txt /opt/mpm_input_r2023b.txt

RUN mpm install --inputfile /opt/mpm_input_r2023b.txt 

USER ${NB_UID}
