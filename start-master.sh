#!/usr/bin/env bash
docker pull segy/docker-spark
docker run -d -t -P -p 7077:7077 -p 8085:8080 --name spark_master --net spark-net --net-alias spark_master segy/docker-spark /start-master.sh "$@"
