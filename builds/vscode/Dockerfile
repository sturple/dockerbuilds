FROM codercom/code-server:v2

USER root

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    nodejs npm ;

#RUN curl -sS https://getcomposer.org/installer | php -- \
#    --filename=composer \
#    --install-dir=/usr/local/bin; 

USER coder
EXPOSE 8081
ENTRYPOINT ["dumb-init", "code-server", "--host", "0.0.0.0", "--port", "8080" ]