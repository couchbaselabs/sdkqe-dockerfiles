FROM maven

ADD entrypoint.sh /entrypoint.sh

RUN apt-get update -y
RUN apt-get install -y git vim sshpass

ENTRYPOINT ["/entrypoint.sh"]
