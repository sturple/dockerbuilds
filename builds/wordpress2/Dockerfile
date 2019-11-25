FROM php:7.2-apache
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      libjpeg-dev \
      libpng-dev \
    ; \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
    docker-php-ext-install gd mysqli opcache zip;

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite expires

VOLUME /var/www/html

ENV WORDPRESS_VERSION 5.0.2
ENV WORDPRESS_SHA1 4a6971d35eb92e2fc30034141b1c865e8c156add

# Wordpress cli for automatic site creation and for adding additional stuff to wp-config.php
RUN set -ex; \
    curl -o  wp-cli https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    cp wp-cli /usr/local/bin/ ; \
    chmod +x /usr/local/bin/wp-cli ;

# Worpress download and permissions.  The acutal move of wordpress to /var/www/html is done by docker-entrypoint.sh
RUN set -ex; \
    curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-5.0.2.tar.gz"; \
    echo "${WORDPRESS_SHA1} *wordpress.tar.gz" | sha1sum -c -; \
    tar -xzf wordpress.tar.gz -C /usr/src/; \
    rm wordpress.tar.gz; \
    mkdir -p /usr/src/wordpress/wp-content/uploads; \
    chown -R www-data:www-data /usr/src/wordpress ;

# This is where the magic happens
COPY docker-entrypoint.sh /usr/local/bin/
#COPY dev.local.conf /etc/apache2/sites-available/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
