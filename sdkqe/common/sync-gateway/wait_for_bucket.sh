#!/bin/bash

CONTAINER_IPS=($(cat /etc/hosts | grep container | awk '{print $1}' | sort))

# IP of the first node of couchbase server
host=${CONTAINER_IPS[0]}

bucket_size=0

i=0
while [ -z $bucket_size ] || [ $bucket_size -le $1 ];
do
	echo "$((i++)) Waiting for bucket size to be $1. Current size is $bucket_size"
	sleep 2
	bucket_size=`curl -su Administrator:password http://$host:8091/pools/default/buckets/default/stats | perl -lne '/\"curr_items\":\[[0-9,,]+,([0-9]+)\],/; print $1'`
done
