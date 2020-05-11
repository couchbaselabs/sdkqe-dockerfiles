FROM centos:centos7

ARG VER=1.4.2
ARG BUILD=366

ENV PATH $PATH:/opt/couchbase-sync-gateway/bin
ENV PKG couchbase-sync-gateway-enterprise_${VER}-${BUILD}_x86_64.rpm

# Install dependencies:
#  wget: for downloading Sync Gateway package installer
RUN yum -y update && \
    yum install -y \
    wget perl && \
    yum clean all

# Install Sync Gateway
RUN wget http://latestbuilds.hq.couchbase.com/couchbase-sync-gateway/$VER/$VER-$BUILD/$PKG && \
    rpm -i $PKG && \
    rm $PKG

# Create directory where the default config stores memory snapshots to disk
RUN mkdir /opt/couchbase-sync-gateway/data

# add the default config into the container
ADD config/sync_gateway_config.json /etc/sync_gateway/config.json

ADD host2ip.sh /host2ip.sh
ADD wait_for_bucket.sh /wait_for_bucket.sh
ADD entrypoint.sh /entrypoint.sh

# Invoke the sync_gateway executable by default
ENTRYPOINT ["/entrypoint.sh"]

# If user doesn't specify any args, use the default config
CMD ["/etc/sync_gateway/config.json"]

# Expose ports
#  port 4984: public port
EXPOSE 4984

