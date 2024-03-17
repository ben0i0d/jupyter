FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:scir-c

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /tmp

EXPOSE 4040

USER root

# Spark dependencies
# Default values can be overridden at build time
ARG spark_version="3.5.0"
ARG hadoop_version="3"

# Configure Spark
ENV SPARK_HOME=/usr/local/spark
ENV SPARK_OPTS="--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info" \
    PATH="${PATH}:${SPARK_HOME}/bin" \
    APACHE_SPARK_VERSION="${spark_version}" \
    HADOOP_VERSION="${hadoop_version}" \
    # RSpark config
    R_LIBS_USER="${SPARK_HOME}/R/lib"

# Configure IPython system-wide
COPY ipython_kernel_config.py "/etc/ipython/"
RUN fix-permissions "/etc/ipython/" && \
  apt-get update --yes && \
  apt-get install --yes --no-install-recommends "openjdk-17-jre-headless" ca-certificates-java && \
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
# You need to use https://archive.apache.org/dist/ website if you want to download old Spark versions
# But it seems to be slower, that's why we use recommended site for download
  wget -qO "spark.tgz" "https://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"; \
  tar xzf "spark.tgz" -C /usr/local --owner root --group root --no-same-owner && \
  rm "spark.tgz" && \
  ln -s "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" "${SPARK_HOME}"; \
  # Add a link in the before_notebook hook in order to source automatically PYTHONPATH && \
  mkdir -p /usr/local/bin/before-notebook.d && \
  ln -s "${SPARK_HOME}/sbin/spark-config.sh" /usr/local/bin/before-notebook.d/spark-config.sh && \
  fix-permissions "${R_LIBS_USER}"
  
USER ${NB_UID}

WORKDIR "${HOME}"

