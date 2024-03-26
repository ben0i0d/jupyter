FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:scipyjo-c

 

# install torch transformers
RUN pip install tensorrt transformers && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu && \
    pip cache purge

