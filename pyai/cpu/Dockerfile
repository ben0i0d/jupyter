FROM ben0i0d/jupyter:scipy-c

 

# install torch transformers
RUN pip install tensorrt transformers && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu && \
    pip cache purge

