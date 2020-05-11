#!/bin/bash

DOCKER_REPO=sdk-s435.sc.couchbase.com
IMAGE_NAME=sdk-java-functional

# Variables                 Option
SDKQE_COMMIT=master         #-c
SDK_COMMIT=master           #-m
CORE_COMMIT=master          #-r
ENCRYPTION_COMMIT=master    #-e
FORCE=false                 #-f

while getopts ":c:m:r:e:f:" OPT; do
        case ${OPT} in
                c) SDKQE_COMMIT=${OPTARG}
                ;;
                m) SDK_COMMIT=${OPTARG}
                ;;
                r) CORE_COMMIT=${OPTARG}
                ;;
                e) ENCRYPTION_COMMIT=${OPTARG}
                ;;
                f) FORCE=${OPTARG}
                ;;
                \?) echo "Invalid option -${OPTARG}"; exit
                ;;
        esac
done

# checkout sdkqe
(rm -rf sdk-qe && git clone git@github.com:couchbaselabs/sdk-qe.git && cd sdk-qe && git checkout ${SDKQE_COMMIT})
SDKQE_COMMIT=$(cd sdk-qe && git describe --always)
TAG=${IMAGE_NAME}_${SDKQE_COMMIT}

# if image is already there, don't build again
if [ "${FORCE}" != "true" ] && [ ! "$(docker images -q ${DOCKER_REPO}/${IMAGE_NAME}:${TAG} 2> /dev/null)" == "" ]; then
        echo "Successfully tagged ${DOCKER_REPO}/${IMAGE_NAME}:${TAG}"
        exit
fi


docker build \
	--build-arg SDK_COMMIT=${SDK_COMMIT} \
	--build-arg CORE_COMMIT=${CORE_COMMIT} \
	--build-arg ENCRYPTION_COMMIT=${ENCRYPTION_COMMIT} \
	-t ${DOCKER_REPO}/${IMAGE_NAME}:${TAG} .
