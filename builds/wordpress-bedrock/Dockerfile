FROM nginx:1.12.1

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    php7.0-fpm; 


COPY wordpress.conf /etc/nginx/conf.d/
