FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/index.html /var/www/static/

COPY tools/init_static.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_static.sh

ENTRYPOINT ["init_static.sh"]
