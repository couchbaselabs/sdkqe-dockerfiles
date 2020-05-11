#!/bin/bash

export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8

set -e

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


# build java-dcp-client
PACKAGE_NAME=java-dcp-client

echo '' > $STATUS_DIR/$PACKAGE_NAME-building

MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=$LOG_DIR"

echo "Building $PACKAGE_NAME"
cd $DATA_DIR/lib/java-dcp-client
mvn clean install -DskipTests=true -Dmaven.repo.local=$BUILD_STASH

echo '' > $STATUS_DIR/$PACKAGE_NAME-ready

# build basic client
PACKAGE_NAME=basic
echo '' > $STATUS_DIR/$PACKAGE_NAME-building

# build dcp-client application
cd $DATA_DIR/client/basic
echo "Building $PACKAGE_NAME"
mvn clean package -DskipTests=true -Dmaven.repo.local=$BUILD_STASH
rc=$?
if [[ $rc -ne 0 ]] ; then
  exit $rc
fi
echo '' > $STATUS_DIR/$PACKAGE_NAME-ready
( umask 0 && truncate -s0 $LOG_DIR/dcp-data.log )
tail -n0 -F $LOG_DIR/dcp-data.log &
wait
