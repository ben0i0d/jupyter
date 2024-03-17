FROM eoelab.org:1032/build-image-stacks/jupyter-image-stacks/jupyter:scipyjo-c

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /tmp

EXPOSE 8081

USER root

# Configure Spark
ENV FLINK_HOME=/usr/local/flink \
    PATH="${PATH}:/usr/local/flink/bin" \
    FLINK_VERSION="1.18.0" 

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends "openjdk-17-jre-headless" ca-certificates-java && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget -qO "flink.tgz" "https://mirrors.tuna.tsinghua.edu.cn/apache/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.12.tgz"; \
    tar xzf "flink.tgz" -C /usr/local --owner root --group root --no-same-owner && \
    rm "flink.tgz" 

USER ${NB_UID}

# Install pyflink
RUN mamba install --yes 'apache-beam' && mamba install --yes 'apache-flink' && \
    mamba clean --all -f -y 

WORKDIR "${HOME}"

