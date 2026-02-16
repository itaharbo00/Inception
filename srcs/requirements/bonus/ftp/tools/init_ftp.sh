#!/bin/bash

# Create FTP user
if ! id -u ${FTP_USER} &>/dev/null; then
    useradd -m ${FTP_USER}
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
    chown -R ${FTP_USER}:${FTP_USER} /var/www/html
fi

# Create necessary directories
mkdir -p /var/run/vsftpd/empty

# Start vsftpd
exec /usr/sbin/vsftpd /etc/vsftpd.conf
