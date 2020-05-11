#!/bin/bash

set -e

if [ -z "$1" ]
        then echo "Need TEST_NAME"
        exit 1
fi

WORK_DIR=/work/${HOSTNAME}
DATA_DIR=/data
LOG_DIR=$WORK_DIR/log
BUILD_STASH=$DATA_DIR/stash

if [ ! -d "$LOG_DIR" ]; then
    mkdir -p $LOG_DIR
fi


BUILD_STASH=${DATA_DIR}/stash

if [ ! -d "$BUILD_STASH" ]; then
    mkdir -p $BUILD_STASH
fi

MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=$LOG_DIR"

# build java-dcp-test
PACKAGE_NAME=java-dcp-test
MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=$LOG_DIR"
echo "Building $PACKAGE_NAME"
cd $DATA_DIR/lib/java-dcp-test
mvn clean install -DskipTests=true -Dmaven.repo.local=$BUILD_STASH

# build test case
cd ${DATA_DIR}/test/$1
echo "Building package"
mvn clean package -DskipTests=true -Dmaven.repo.local=$BUILD_STASH
rc=$?
if [[ $rc -ne 0 ]] ; then
  exit $rc
fi


# run test case
echo "Running test $*"
export MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=${WORK_DIR}/log"
mvn exec:java -DskipTests=true -Dmaven.repo.local=$BUILD_STASH -Dexec.args="$2"

