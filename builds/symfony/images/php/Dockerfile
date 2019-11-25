FROM php:7.3-apache-stretch

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    git curl openssh-client libjpeg-dev libpng-dev libzip-dev zip unzip ssmtp less mysql-client libxslt-dev gnupg apt-transport-https vim; 


RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \ 
    docker-php-ext-install gd mysqli opcache zip pdo pdo_mysql xsl intl;

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add - ; \
    curl -sL https://deb.nodesource.com/setup_12.x | bash -; \
    curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin; \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list ; \
    set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends yarn nodejs

RUN chown -R $(id -u) /var/www/html/
RUN a2enmod rewrite
EXPOSE 443
