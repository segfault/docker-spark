#!/usr/bin/env bash
docker build -t docker-spark .
# docker pull epahomov/docker-spark
docker run -d -t -P --name spark_master docker-spark /start-master.sh "$@"
