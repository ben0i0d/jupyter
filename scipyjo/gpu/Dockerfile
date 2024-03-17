FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:pyjo-g

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends build-essential cm-super dvipng ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Install Python 3 packages
RUN mamba install --yes \
    # Data analysis and visualization
    'altair' 'pandas' 'matplotlib' \
    # Performance optimization
    'bottleneck' 'numba' 'numexpr' \
    # Data storage and processing
    'dask' 'dill' 'openpyxl' 'pytables' 'xlrd'  \
    # Programming and extension
    'cython' 'protobuf' 'sympy' \
    # Machine learning and data mining
    'scikit-learn' 'statsmodels' \
    # Scientific calculations and statistical analysis
    'scipy' 'patsy' 'numpy' 'mkl' &&\
    pip install --upgrade "jax[cuda12_pip]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html && \
    mamba clean --all -f -y  && \
    pip cache purge && \
    MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"
