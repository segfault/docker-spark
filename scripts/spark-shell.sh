#!/usr/bin/env bash
SPARK_MASTER_PORT_7077_TCP_ADDR=`getent hosts spark_master | awk '{ print $1 }'`
export SPARK_LOCAL_IP=`hostname -I | awk '{print $1}'`
/remove_alias.sh # problems with hostname alias, see https://issues.apache.org/jira/browse/SPARK-6680
cd /usr/local/spark
./bin/spark-shell \
	--master spark://${SPARK_MASTER_PORT_7077_TCP_ADDR:-spark_master}:${SPARK_MASTER_ENV_SPARK_MASTER_PORT:-7077}  \
	-i ${SPARK_LOCAL_IP} \
	--properties-file /spark-defaults.conf \
	"$@" 
