FROM ben0i0d/jupyter:py-g

# Install Python 3 packages
RUN pip install \
    # Data analysis and visualization
    'pandas' 'matplotlib' \
    # Machine learning and data mining
    'scikit-learn' \
    # Scientific calculations and statistical analysis
    'scipy' 'numpy' &&\
    pip install --upgrade "jax[cuda12_pip]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html && \
    pip cache purge && \
    MPLBACKEND=Agg python -c "import matplotlib.pyplot" 
