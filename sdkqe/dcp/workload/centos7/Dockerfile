FROM centos:7

WORKDIR /work

RUN yum update -y
RUN yum install junit -y
RUN yum install maven -y
RUN mkdir /conf

COPY logback.xml /conf
COPY start.sh /start.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["couchbase-a-0", "default"]
