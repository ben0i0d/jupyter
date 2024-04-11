FROM ben0i0d/jupyter:py-c

# Install Python 3 packages
RUN pip install  \
    # Data analysis and visualization
    'pandas' 'matplotlib' \
    # Machine learning and data mining
    'scikit-learn' 'jax' \
    # Scientific calculations and statistical analysis
    'scipy' 'numpy' &&\
    pip cache purge  && \
    MPLBACKEND=Agg python -c "import matplotlib.pyplot" 
