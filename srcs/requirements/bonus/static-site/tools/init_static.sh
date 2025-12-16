#!/bin/bash

# Start NGINX in foreground
exec /usr/sbin/nginx -g "daemon off;"
