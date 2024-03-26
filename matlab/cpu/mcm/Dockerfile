FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:matlab-c-minimal

 

USER root

COPY conf/mpm_input_r2023b.txt /opt/mpm_input_r2023b.txt

RUN mpm install --inputfile /opt/mpm_input_r2023b.txt 

USER ${NB_UID}
