#!/bin/bash

# Wait for MariaDB to be ready
while ! mariadb -h mariadb -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1" &>/dev/null; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "MariaDB is ready!"

cd /var/www/html

# Download WordPress if not already present
if [ ! -f "wp-config.php" ]; then
    # Download WordPress core files
    wp core download --allow-root

    # Create wp-config.php
    wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb \
        --allow-root

    # Add Redis configuration to wp-config.php
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root
    wp config set WP_CACHE true --raw --allow-root

    # Install WordPress
    wp core install \
        --url=${DOMAIN_NAME} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    # Create second user
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --role=author \
        --allow-root

    # Install Redis Object Cache plugin
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root

    echo "WordPress installed successfully!"
fi

# Set correct permissions
chown -R www-data:www-data /var/www/html

#Start PHP-FPM in foreground
exec php-fpm8.2 -F
