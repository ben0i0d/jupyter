FROM ben0i0d/jupyter:py-c

USER root

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
# install chrome
    apt-get update && apt-get -y install google-chrome-stable && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
# install chromedriver
    wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip  && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && \
# Install Python 3 packages
    pip install 'beautifulsoup4' 'requests' 'selenium' 'schedule' && \
    pip cache purge 

USER ${NB_UID}
