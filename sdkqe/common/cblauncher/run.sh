#!/bin/bash

NODE_LIST=$(env |egrep NODE[0-9]+=)
readarray -t ARR_NODE <<< "${NODE_LIST}"
NUM_NODES="${#ARR_NODE[@]}"

NS_NODENAMES=""
for i in `seq 1 ${NUM_NODES}`
do
  NEWNODE=$(eval echo \$"NODE${i}")
  if [ ${i} -eq 1 ]; then
    NS_NODENAMES=ns_1%40${NEWNODE}
  else
   NS_NODENAMES=${NS_NODENAMES}%2Cns_1%40${NEWNODE}
  fi
done

#init first node
curl -s -u Administrator:password -X POST -d memoryQuota=2000 http://${NODE1}:8091/pools/default
curl -s -u Administrator:password -X POST http://${NODE1}:8091/node/controller/rename -d "hostname=${NODE1}"
curl -s -u Administrator:password -X POST http://${NODE1}:8091/node/controller/setupServices -d "services=${SERVICES1}"
curl -s -u Administrator:password -X POST http://${NODE1}:8091/settings/web -d "password=password&username=Administrator&port=SAME"

# create default bucket
curl -s -u Administrator:password -X POST http://${NODE1}:8091/pools/default/buckets -d "name=default" -d "ramQuotaMB=200"

# add nodes
i="1"
while :
do
    CB_IP=$(eval echo \$NODE${i})
	CB_SERVICES=$(eval echo \$SERVICES${i})
    echo "CB_SERVICES=${CB_SERVICES}"
    if [ -z ${CB_IP} ]; then
        break
    fi
    if [ "${CB_IP}" != "${NODE1}" ]; then
        echo "Adding ${CB_IP}"
        curl -s -u Administrator:password -X POST http://${NODE1}:8091/controller/addNode\
                -d "hostname=${CB_IP}&user=Administrator&password=password&services=${CB_SERVICES}"
    fi
    i=$[${i}+1]
done
curl -s -u Administrator:password -X POST http://${NODE1}:8091/controller/rebalance -d "ejectedNodes=&knownNodes=${NS_NODENAMES}"

./set_altenate_name.pl

