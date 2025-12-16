FROM debian:bookworm

RUN apt-get update && apt-get install -y wget gnupg ca-certificates \
    && wget https://github.com/google/cadvisor/releases/download/v0.54.1/cadvisor-v0.54.1-linux-amd64 -O /usr/bin/cadvisor \
    && chmod +x /usr/bin/cadvisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY conf/cadvisor.conf /etc/cadvisor/cadvisor.conf
COPY tools/init_cadvisor.sh /usr/local/bin/init_cadvisor.sh
RUN chmod +x /usr/local/bin/init_cadvisor.sh

ENTRYPOINT ["init_cadvisor.sh"]
