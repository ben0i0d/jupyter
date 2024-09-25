FROM eoelab.org:1027/ben0i0d/jupyter:py-c AS builder

USER root
# You need to use https://archive.apache.org/dist/ website if you want to download old Spark versions
# But it seems to be slower, that's why we use recommended site for download
RUN apt-get update --yes && apt-get install --yes --no-install-recommends wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget -qO "spark.tgz" "https://mirrors.ustc.edu.cn/apache/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz" && \
    tar xzf "spark.tgz" -C /usr/local --no-same-owner && rm "spark.tgz" 

FROM eoelab.org:1027/ben0i0d/jupyter:py-c

USER root

# Configure Spark
ENV SPARK_OPTS="--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info" \
    SPARK_HOME=/usr/local/spark \
    PATH="${PATH}:/usr/local/spark/bin" 

# Configure IPython system-wide
COPY ipython_kernel_config.py "/etc/ipython/"
COPY --chown="root:root" --from=builder /usr/local/spark-3.5.3-bin-hadoop3/ /usr/local/spark-3.5.3-bin-hadoop3/

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends openjdk-17-jre-headless ca-certificates-java && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    ln -s "spark-3.5.3-bin-hadoop3" "/usr/local/spark" && \
# Add a link in the before_notebook hook in order to source automatically PYTHONPATH
    mkdir -p /usr/local/bin/before-notebook.d && \
    ln -s "/usr/local/spark/sbin/spark-config.sh" /usr/local/bin/before-notebook.d/spark-config.sh

USER ${NB_UID}

# Install pyarrow+findspark
RUN pip install 'pyspark' 'findspark' && \
    pip cache purge


