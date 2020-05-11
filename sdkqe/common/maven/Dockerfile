FROM maven

ADD entrypoint.sh /entrypoint.sh
ADD init_cluster.sh /init_cluster.sh

RUN apt-get update -y
RUN apt-get install -y git vim sshpass telnet
RUN wget https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz
RUN apt-get install -y build-essential
RUN apt-get install -y cmake
ENV PATH $PATH:/usr/local/go/bin

ENTRYPOINT ["/entrypoint.sh"]
