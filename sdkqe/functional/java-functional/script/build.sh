#!/bin/bash

SDK_COMMIT=${1:-master}
CORE_COMMIT=${2:-master}
ENCRYPTION_COMMIT=${3:-master}

cd /root/sdk-qe/functional-tests/java-functional && ./build_lib.sh ${SDK_COMMIT} ${CORE_COMMIT} ${ENCRYPTION_COMMIT}
