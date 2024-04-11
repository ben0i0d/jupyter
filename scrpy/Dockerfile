FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:pyjo-c

 

USER root
# install system dependencies
RUN apt-get update && apt-get -y install gcc make
#add chrome source
COPY linux_signing_key.pub ./linux_signing_key.pub
RUN apt-key add linux_signing_key.pub && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
# install chrome
    apt-get update && apt-get -y install google-chrome-stable && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
# install chromedriver
    wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip  && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && \
# Install Python 3 packages
    mamba install --yes 'beautifulsoup4' 'requests' 'selenium' 'schedule' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}
