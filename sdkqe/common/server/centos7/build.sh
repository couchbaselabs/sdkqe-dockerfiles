#!/bin/bash
docker build -t sdk-s435.sc.couchbase.com/couchbase-server:centos7 . && docker push sdk-s435.sc.couchbase.com/couchbase-server:centos7
