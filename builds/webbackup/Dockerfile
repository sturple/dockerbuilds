FROM python:3.5.5-slim-jessie

RUN apt-get update; \
    apt-get -y install python3-pip git;

WORKDIR /app/
VOLUME /app/config/
VOLUME /app/backups/

RUN mkdir -p /app/config; \
    mkdir -p /app/webbackup; \
    mkdir -p /app/backups/Websites; \
    mkdir -p /app/backups/Archives; \
    mkdir -p /app/backups/log; \
    mkdir -p /app/backups/tmp; \
    mkdir -p /app/pem; \
    pip3 install paramiko; \
    pip3 install pyyaml; 

COPY ssh_config /etc/ssh/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
