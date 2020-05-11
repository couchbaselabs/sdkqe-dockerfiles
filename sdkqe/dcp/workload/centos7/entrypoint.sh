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

# build workloader
export MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=$LOG_DIR"

cd $DATA_DIR/workload/$1
echo "Building package"
mvn package -DskipTests=true -Dmaven.repo.local=$BUILD_STASH
rc=$?
if [[ $rc -ne 0 ]] ; then
  exit $rc
fi
( umask 0 && truncate -s0 $LOG_DIR/workload.log )
tail -n0 -F $LOG_DIR/workload.log &
wait
