#!/usr/bin/env bash
docker pull segy/docker-spark
docker run -d -t -P --net spark-net segy/docker-spark /start-worker.sh "$@"
