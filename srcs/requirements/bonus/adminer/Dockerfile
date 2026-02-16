FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    php-fpm \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download Adminer
RUN mkdir -p /var/www/html \
    && curl -L https://www.aminer.org/latest.php -o /var/www/html/index.php

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Init script
COPY tools/init_adminer.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_adminer.sh

EXPOSE 9000

ENTRYPOINT ["init_adminer.sh"]
