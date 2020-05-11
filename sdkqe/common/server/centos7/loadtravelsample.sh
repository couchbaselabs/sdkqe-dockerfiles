#!/bin/bash

 /opt/couchbase/bin/cbdocloader -n localhost:8091 -u Administrator -p password -b default -s 100 /opt/couchbase/samples/travel-sample.zip 

