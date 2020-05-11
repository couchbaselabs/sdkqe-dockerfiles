#!/bin/bash

# replace node0 in /etc/sync_gateway/config.json with couchbase node IP
/host2ip.sh /etc/sync_gateway/config.json

# wait for 200 items filled in default bucket
/wait_for_bucket.sh 100

# start sync gateway
exec sync_gateway /etc/sync_gateway/config.json
