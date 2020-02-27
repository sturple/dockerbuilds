FROM codercom/code-server:v2

USER root

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    nodejs npm python3.6 python-pip python3-pip;

#RUN curl -sS https://getcomposer.org/installer | php -- \
#    --filename=composer \
#    --install-dir=/usr/local/bin; 

USER 1000

ENTRYPOINT ["dumb-init", "code-server", "--host", "0.0.0.0", "--auth", "none" ]
