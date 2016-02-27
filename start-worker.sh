#!/usr/bin/env bash
docker pull segy/docker-spark
docker run -d -t -P --link spark_master:spark_master segy/docker-spark /start-worker.sh "$@"
