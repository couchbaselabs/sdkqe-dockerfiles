#!/bin/bash

FILE=${1:-/etc/sync_gateway/config.json}

CONTAINER_IPS=($(cat /etc/hosts | grep container | awk '{print $1}' | sort))
addr=${CONTAINER_IPS[0]}

# Read "server": "http://node0:8091" and replace node0 with the first couchbase node IP
sed -i "s/\(node0\)\(.*\)/${addr}\2/" $FILE
