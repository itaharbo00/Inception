#!/bin/bash

# Generate self-signed SSL certificate if it doesn't exist
if [ ! -f "/etc/nginx/ssl/inception.crt" ]; then
    mkdir -p /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=itaharbo42" \
        -addext "subjectAltName=DNS:itaharbo.42.fr,DNS:mysite.test"
    echo "SSL certificate for NGINX generated!"
fi

# Start NGINX in foreground
exec nginx -g "daemon off;"
