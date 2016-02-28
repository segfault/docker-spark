#!/usr/bin/env bash
docker pull segy/docker-spark
docker run -d -t -P --name spark_master segy/docker-spark /start-master.sh "$@"
