FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

USER root
# You need to use https://archive.apache.org/dist/ website if you want to download old Spark versions
# But it seems to be slower, that's why we use recommended site for download
RUN apt-get update --yes && apt-get install --yes --no-install-recommends wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget -qO "flink.tgz" "https://mirrors.ustc.edu.cn/apache/flink/flink-1.20.0/flink-1.20.0-bin-scala_2.12.tgz" && \
    tar xzf "flink.tgz" -C /usr/local --no-same-owner && rm "flink.tgz" 

FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root

# Configure Spark
ENV FLINK_HOME=/usr/local/flink \
    PATH="${PATH}:/usr/local/flink/bin"

COPY --from=builder --chown="${NB_UID}:${NB_GID}" /usr/local/flink-1.20.0/ /usr/local/flink-1.20.0/

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends openjdk-17-jre-headless ca-certificates-java && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    ln -s "flink-1.20.0" "/usr/local/flink" 

USER ${NB_UID}

# Install pyflink
RUN pip install apache-flink && \
    pip cache purge