FROM centos:7

ARG SDK_COMMIT=master
ARG CORE_COMMIT=master
ARG ENCRYPTION_COMMIT=master

WORKDIR /root
# install base packages
RUN yum update -y
RUN yum install -y wget nmap openssl-devel openssl
RUN yum install -y epel-release
RUN yum install -y jq sshpass

RUN yum install -y http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
RUN yum install -y git
RUN wget -q -4 https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz

# enviornment to build sdk
ENV BIN=/root/bin
ENV PATH=${PATH}:${BIN}:/usr/local/go/bin
ENV GOPATH=/gopath

RUN mkdir ${GOPATH}
RUN mkdir ${BIN}
RUN mkdir -p ${GOPATH}/src/github.com/couchbase
RUN mkdir -p ${GOPATH}/src/github.com/couchbaselabs

#RUN go get github.com/couchbase/gocb
RUN git clone https://github.com/couchbaselabs/gocbv14.git ${GOPATH}/src/github.com/couchbase/gocb
#RUN git clone https://github.com/couchbase/gocb ${GOPATH}/src/github.com/couchbase/gocb
RUN git clone https://github.com/couchbase/gocbencryption ${GOPATH}/src/github.com/couchbase/gocbencryption

RUN go get gopkg.in/couchbase/gocbcore.v7 github.com/golang/glog github.com/tebeka/go2xunit/lib github.com/stretchr/testify/assert github.com/hnakamur/go-scp
RUN go get gopkg.in/couchbaselabs/jsonx.v1 gopkg.in/couchbaselabs/gocbconnstr.v1
RUN go get gopkg.in/couchbase/gocb.v1
RUN go get golang.org/x/net/http2 github.com/google/uuid github.com/opentracing/opentracing-go
RUN git clone https://github.com/tebeka/go2xunit.git
RUN cd go2xunit && go build && cp go2xunit /root/bin/ && cd ..

ADD script/entrypoint.sh	${BIN}/entrypoint.sh
ADD sdk-qe			${GOPATH}/src/github.com/couchbaselabs/sdk-qe

# add runtime ini-files
WORKDIR ${GOPATH}/src/github.com/couchbaselabs/sdk-qe/functional-tests/go-functional

ENTRYPOINT ["entrypoint.sh"]
