FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:scipyjo-g

 

# install torch transformers
RUN pip install transformers && \
    pip install torch torchvision torchaudio && \
    pip cache purge

