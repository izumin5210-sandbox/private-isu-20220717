#!/usr/bin/env bash

set -e


timestamp=$(date +'%H%M%S')
LOG_DIR="/home/${USER}/log/${timestap}"

mkdir -p $LOG_DIR

sudo cp /var/log/nginx/access.log ${LOG_DIR}/nginx.access.log
sudo cp /var/log/mysql/mysql-slow.log ${LOG_DIR}/mysql.slow.log

sudo systemctl reload nginx
sudo systemctl restart mysql

sudo cat ${LOG_DIR}/nginx.access.log | ./alp json --sort sum -r -m '/image/\d+.\w+','/posts/\d+','/@\w+'
sudo mysqldumpslow ${LOG_DIR}/mysql.slow.log
