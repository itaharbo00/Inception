FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/init_ftp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_ftp.sh

EXPOSE 21 21100-21110

ENTRYPOINT ["init_ftp.sh"]
