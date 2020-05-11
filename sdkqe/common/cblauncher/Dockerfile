FROM centos:7

WORKDIR /root
# install base packages
RUN yum update -y
RUN yum install -y wget nmap perl docker-io

ADD entrypoint.sh /root/entrypoint.sh
ADD run.sh /root/run.sh
ADD set_altenate_name.pl /root/set_altenate_name.pl

ENTRYPOINT ["./entrypoint.sh"]
