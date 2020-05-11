FROM centos:7

ARG SDK_COMMIT=master
ARG CORE_COMMIT=master
ARG ENCRYPTION_COMMIT=master

WORKDIR /root
# install base packages
RUN yum update -y
RUN yum install -y java-1.8.0-openjdk-devel git wget openssl-devel openssl nmap
RUN yum install -y epel-release
RUN yum install -y jq sshpass
ENV JAVA_HOME=/usr/lib/jvm/java


# install maven 3.3.9
RUN wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar xzf apache-maven-3.3.9-bin.tar.gz
RUN rm apache-maven-3.3.9-bin.tar.gz
RUN ln -s apache-maven-3.3.9 maven
ENV BIN=/root/bin
ENV PATH=${PATH}:/root/maven/bin:${BIN}

RUN mkdir ${BIN}
ADD script/entrypoint.sh	${BIN}/entrypoint.sh
ADD script/build.sh		${BIN}/build.sh
ADD sdk-qe					/root/sdk-qe

RUN build.sh $SDK_COMMIT $CORE_COMMIT $ENCRYPTION_COMMIT

# add runtime ini-files
WORKDIR /root/sdk-qe/functional-tests/java-functional

ENTRYPOINT ["entrypoint.sh"]
