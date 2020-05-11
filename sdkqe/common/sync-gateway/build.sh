#!/bin/bash

VER=${1:-1.4.2}
BUILD=${2:-366}

echo Building an Image with Sync Gateway version ${VER}-${BUILD}

docker build \
	--build-arg VER=${VER} \
	--build-arg BUILD=${BUILD} \
	-t sequoiatools/sdksg .

