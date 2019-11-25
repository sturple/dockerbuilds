FROM php:7.2.7-apache
COPY setup.sh /tmp/
WORKDIR /tmp/
RUN apt-get update; \
    chmod +x /tmp/setup.sh; \
    /bin/bash /tmp/setup.sh; 

WORKDIR /var/www/html/
VOLUME ['/var/www/html']
EXPOSE 80/tcp
    #apt-get install -y git composer; \
    #git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /root/wpcs
