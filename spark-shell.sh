#!/usr/bin/env bash
docker pull segy/docker-spark
docker run -i -t -P --link spark_master:spark_master segy/docker-spark /spark-shell.sh "$@"
