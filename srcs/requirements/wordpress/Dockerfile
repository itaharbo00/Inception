FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-intl \
    php-mbstring \
    php-xml \
    php-zip\
    php-redis \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Download WP-CLI (WordPress command line tool)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy custom configuration PHP-FPM to listen on port 9000
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/

# Create directory for PHP-FPM pid file
RUN mkdir -p /run/php

# Copy initialization script
COPY tools/init_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_wp.sh

# WordPress directory
WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["init_wp.sh"]
