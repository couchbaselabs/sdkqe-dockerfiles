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

cd $DATA_DIR/client/$1
echo "Start $1"
export MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=$LOG_DIR"

if [ -z "$2" ]
        then echo "Need space separated parameters"
        exit 1
fi

echo "args=$2"

mvn exec:java -Dexec.mainClass="$2" -DskipTests=true -Dmaven.repo.local=$BUILD_STASH -Dexec.args="$*"
