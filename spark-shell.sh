#!/usr/bin/env bash
docker pull segy/docker-spark
docker run -i -t -P --net spark-net segy/docker-spark /spark-shell.sh "$@"
