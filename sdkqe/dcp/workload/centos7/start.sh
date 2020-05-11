#!/bin/bash

WORK_DIR=/work/${HOSTNAME}
DATA_DIR=/data
LOG_DIR=$WORK_DIR/log
BUILD_STASH=$DATA_DIR/stash

if [ ! -d "$LOG_DIR" ]; then
    mkdir -p $LOG_DIR
fi

if [ ! -d "$BUILD_STASH" ]; then
    mkdir -p $BUILD_STASH
fi

cd $DATA_DIR/workload/$1
echo "Start $1"
export MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=$LOG_DIR"

if [ -z "$1" ]
	then echo "Need workload generator name"
	exit 1
fi

echo "args1=$1"
echo "args2=$2"

mvn exec:java -DskipTests=true -Dmaven.repo.local=$BUILD_STASH -Dexec.args="$*"
