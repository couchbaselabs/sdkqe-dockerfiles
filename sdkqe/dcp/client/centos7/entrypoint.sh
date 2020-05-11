#!/bin/bash

export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8

set -e

if [ -z "$1" ]
        then echo "Need CLIENT NAME"
        exit 1
fi

WORK_DIR=/work/${HOSTNAME}
DATA_DIR=/data
LOG_DIR=${WORK_DIR}/log
BUILD_STASH=${DATA_DIR}/stash
STATUS_DIR=/status

if [ ! -d "$LOG_DIR" ]; then
    mkdir -p $LOG_DIR
fi


if [ ! -d "$BUILD_STASH" ]; then
    mkdir -p $BUILD_STASH
fi

MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=$LOG_DIR"

# wait for dcp-client application is built
while [ ! -f $STATUS_DIR/basic-ready ]
do
	sleep 2
done

echo ''>$STATUS_DIR/${HOSTNAME}-ready
echo "dcp client application is ready"

( umask 0 && truncate -s0 $LOG_DIR/dcp-client.log )
tail -n0 -F $LOG_DIR/dcp-client.log &
wait
