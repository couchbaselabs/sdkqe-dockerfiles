#!/bin/bash

CLIENT_COMMIT=${1:-323f8ffc9486eb04466228fcdf525fb2b0c39a79}
CORE_COMMIT=${2:-cf99798c2bb7410396b1d0f97a26da211aafd36e}

PWD=`pwd`

BUILD_STASH=${PWD}/stash

mkdir ${BUILD_STASH}

git clone https://github.com/couchbase/couchbase-jvm-core
(cd couchbase-jvm-core; git checkout ${CORE_COMMIT}; mvn -q -Duser.home=${BUILD_STASH} clean install -DskipTests=true)


git clone https://github.com/couchbase/couchbase-java-client
(cd couchbase-java-client; git checkout ${CLIENT_COMMIT}; mvn -q -Duser.home=${BUILD_STASH} clean install -DskipTests=true)

cp ${BUILD_STASH}/.m2/repository/com/couchbase/client/core-io/1.4.7-SNAPSHOT/core-io-1.4.7-SNAPSHOT.jar .
cp ${BUILD_STASH}/.m2/repository/com/couchbase/client/java-client/2.4.7-SNAPSHOT/java-client-2.4.7-SNAPSHOT.jar .
cp ${BUILD_STASH}/.m2/repository/io/reactivex/rxjava/1.2.7/rxjava-1.2.7.jar .

rm -rf couchbase-java-client
rm -rf couchbase-jvm-core
rm -rf ${BUILD_STASH}


