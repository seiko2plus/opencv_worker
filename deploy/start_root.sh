#!/bin/bash
echo -e '127.0.0.1 code.ocv' >> /etc/hosts
service nginx start
service cron start

