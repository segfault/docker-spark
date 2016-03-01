#!/usr/bin/env bash
export SPARK_MASTER_IP="spark_master"
export SPARK_LOCAL_IP="spark_master"
/usr/local/spark/sbin/start-master.sh --properties-file /spark-defaults.conf -i $SPARK_LOCAL_IP "$@"
/bin/bash
