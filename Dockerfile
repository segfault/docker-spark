############################################################
# Dockerfile for a Apache Spark Development Environment
# Based on Ubuntu Image
############################################################

FROM ubuntu:latest
MAINTAINER NeuralFoundry <neuralfoundry.com>

ENV SPARK_VERSION      1.6.0
ENV SCALA_VERSION      2.11.7
ENV SPARK_BIN_VERSION  $SPARK_VERSION-bin-hadoop2.6
ENV SPARK_HOME         /usr/local/spark
ENV SCALA_HOME         /usr/local/scala
ENV PATH               $PATH:$SPARK_HOME/bin:$SCALA_HOME/bin

# Update the APT cache
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Install and setup project dependencies
RUN apt-get install -y curl wget git
RUN locale-gen en_US en_US.UTF-8

#prepare for Java download
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common

#grab oracle java (auto accept licence)
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Install Scala
RUN wget http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
    tar -zxf /scala-$SCALA_VERSION.tgz -C /usr/local/ && \
    ln -s /usr/local/scala-$SCALA_VERSION $SCALA_HOME && \
    rm /scala-$SCALA_VERSION.tgz
	
# Installing Spark for Hadoop
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_BIN_VERSION.tgz && \
    tar -zxf /spark-$SPARK_BIN_VERSION.tgz -C /usr/local/ && \
    ln -s /usr/local/spark-$SPARK_BIN_VERSION $SPARK_HOME && \
    rm /spark-$SPARK_BIN_VERSION.tgz

ADD scripts/start-master.sh /start-master.sh
ADD scripts/start-worker /start-worker.sh
ADD scripts/spark-shell.sh  /spark-shell.sh
ADD scripts/spark-defaults.conf /spark-defaults.conf
ADD scripts/remove_alias.sh /remove_alias.sh

ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_WORKER_PORT 8888
ENV SPARK_WORKER_WEBUI_PORT 8081

EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006
