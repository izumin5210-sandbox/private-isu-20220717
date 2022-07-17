#!/usr/bin/env bash

set -e

timestamp=$(date +'%H%M%S')
LOG_DIR="/home/${USER}/log/${timestamp}"

mkdir -p $LOG_DIR

sudo mv /var/log/nginx/access.log ${LOG_DIR}/nginx.access.log
sudo mv /var/log/mysql/mysql-slow.log ${LOG_DIR}/mysql.slow.log

sudo systemctl reload nginx
sudo systemctl restart mysql

sudo cat ${LOG_DIR}/nginx.access.log | ./alp json --sort sum -r -m '/image/\d+.\w+','/posts/\d+','/@\w+'
sudo mysqldumpslow ${LOG_DIR}/mysql.slow.log
