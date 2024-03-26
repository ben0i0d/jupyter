FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:pyjo-c

 

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
    'scikit-learn' 'statsmodels' 'jax' \
    # Scientific calculations and statistical analysis
    'scipy' 'patsy' 'numpy' 'mkl' &&\
    mamba clean --all -f -y  && \
    MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"
