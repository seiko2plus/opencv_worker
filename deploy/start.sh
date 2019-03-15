#!/bin/bash
/worker/deploy/sync.sh
spawn-fcgi -u buildbot -g buildbot -M 666 -s /worker/nginx/fcgiwrap.socket /usr/sbin/fcgiwrap
cd /worker/buildbot && buildbot-worker start --nodaemon