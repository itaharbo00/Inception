FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    redis-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/redis.conf
COPY tools/init_redis.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_redis.sh

EXPOSE 6379

ENTRYPOINT ["init_redis.sh"]
