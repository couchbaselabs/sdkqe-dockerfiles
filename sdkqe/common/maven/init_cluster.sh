#!/bin/bash
NODE1=cb1.ipv6.couchbase.com
SERVICES=kv%2Cn1ql%2Cindex%2Cfts
#init first node
curl -s -u Administrator:password -X POST -d memoryQuota=2000 http://${NODE1}:8091/pools/default
curl -s -u Administrator:password -X POST http://${NODE1}:8091/node/controller/rename -d "hostname=${NODE1}"
curl -s -u Administrator:password -X POST http://${NODE1}:8091/node/controller/setupServices -d "services=${SERVICES}"
curl -s -u Administrator:password -X POST http://${NODE1}:8091/settings/web -d "password=password&username=Administrator&port=SAME"
