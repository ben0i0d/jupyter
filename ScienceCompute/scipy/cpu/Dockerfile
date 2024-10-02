FROM eoelab.org:1027/ben0i0d/jupyter:py-c

# Install Python 3 packages
RUN pip install  \
    # Data analysis and visualization
    'matplotlib' \
    # Scientific calculations and statistical analysis
    'numpy' &&\
    pip cache purge  && \
    MPLBACKEND=Agg python -c "import matplotlib.pyplot" 
