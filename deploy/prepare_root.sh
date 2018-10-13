#!/bin/bash

apt-get install -y python3-pip
pip3 install buildbot-worker

groupadd -r buildbot -g 1000
useradd -u 1000 -r -g buildbot -m -d /worker/buildbot -s /bin/bash -c "buildbot user" buildbot

if [ ! -d /worker/buildbot ]; then
	mkdir /worker/buildbot
	chown buildbot:buildbot /worker/buildbot
fi

apt-get install -y nginx fcgiwrap spawn-fcgi cron
usermod -a -G buildbot www-data
cp /worker/deploy/nginx.conf /etc/nginx/sites-enabled/default

echo '*/59 * * * * buildbot /worker/deploy/sync.sh >> /dev/null 2>&1' > /etc/cron.d/gitsync