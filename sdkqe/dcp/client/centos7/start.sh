#!/bin/bash

WORK_DIR=/work/${HOSTNAME}
DATA_DIR=/data
LOG_DIR=$WORK_DIR/log
BUILD_STASH=$DATA_DIR/stash
STATUS_DIR=/status

if [ ! -d "$LOG_DIR" ]; then
    mkdir -p $LOG_DIR
fi

if [ ! -d "$BUILD_STASH" ]; then
    mkdir -p $BUILD_STASH
fi

params=$1
IFS=' '
param=($params)

cd $DATA_DIR/client/${param[0]}
export MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=$LOG_DIR"

if [ -z "$1" ]
        then echo "Need space separated parameters"
        exit 1
fi

# wait for dcp-client application is built
while [ ! -f $STATUS_DIR/${param[0]}-ready ]
do
	echo checking $STATUS_DIR/${param[0]}-ready
        sleep 2
done

echo "dcp client application is ready"

echo "Start ${param[0]}"
mvn exec:java -Dexec.mainClass="${param[1]}" -DskipTests=true -Dmaven.repo.local=$BUILD_STASH -Dexec.args="$*"
