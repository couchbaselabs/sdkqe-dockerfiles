FROM centos:7.2.1511

ENV \
  PKG=rpm \
  PATH=$PATH:/work/bin:/opt/couchbase/bin:/opt/couchbase/bin/tools:/opt/couchbase/bin/install

RUN yum update -y || true

RUN yum install -y yum-plugin-ovl

RUN \
  yum install -y wget chrpath \
  lsof lshw sysstat net-toolsi\
  numactl openssl gdb
RUN \
  yum install -y iptables-services
RUN \
  yum autoremove || true
RUN \
  yum clean packages || true
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Commands are run from this working directory
WORKDIR /work

# Add docker for building containers
ADD docker /work/bin/docker

# Create Couchbase user with UID 1000 (necessary to match default
# boot2docker UID)
RUN groupadd -g 1000 couchbase && useradd couchbase -u 1000 -g couchbase -M

# Install couchbase
#RUN wget -N $CB_RELEASE_URL/$CB_VERSION/$CB_PACKAGE && \
#    echo "$CB_SHA256  $CB_PACKAGE" | sha256sum -c - && \
#    dpkg -i ./$CB_PACKAGE && rm -f ./$CB_PACKAGE
#RUN cp -f ${PACKAGE_FILE} /tmp/ && \
    #rpm -Uvh /tmp/${PACKAGE_NAME}

# Add runit script for couchbase-server
ADD scripts/run /etc/service/couchbase-server/run

# Add dummy script for commands invoked by cbcollect_info that
# make no sense in a Docker container
ADD scripts/dummy.sh /usr/local/bin/
RUN ln -s dummy.sh /usr/local/bin/iptables-save && \
    ln -s dummy.sh /usr/local/bin/lvdisplay && \
    ln -s dummy.sh /usr/local/bin/vgdisplay && \
    ln -s dummy.sh /usr/local/bin/pvdisplay

RUN \
  curl -s https://packagecloud.io/install/repositories/imeyer/runit/script.rpm.sh | bash
RUN \
  yum install -y runit
#pip install httplib2

# Add bootstrap script
ADD scripts/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["couchbase-server"]

# 8091: Couchbase Web console, REST/HTTP interface
# 8092: Views, queries, XDCR
# 8093: Query services (4.0+)
# 8094: Full-text Serarch (4.5+)
# 11207: Smart client library data node access (SSL)
# 11210: Smart client library/moxi data node access
# 11211: Legacy non-smart client library data node access
# 18091: Couchbase Web console, REST/HTTP interface (SSL)
# 18092: Views, query, XDCR (SSL)
# 18093: Query services (SSL) (4.0+)

EXPOSE 8091 8092 8093 8094 11207 11210 11211 18091 18092 18093

#VOLUME /opt/couchbase/var
