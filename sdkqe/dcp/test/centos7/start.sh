#!/bin/bash
cd /work/test/$1
echo "Start $1"
export MAVEN_OPTS="-Dlogback.configurationFile=/conf/logback.xml -DLOG_DIR=/work/test/log"

if [ -z "$1" ]
        then echo "Need space separated parameters"
        exit 1
fi

echo "args=$2"

mvn exec:java -DskipTests=true -Dexec.args="$2"
