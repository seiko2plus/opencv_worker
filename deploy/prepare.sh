#!/bin/bash

if [ -f /worker/deploy/env.sh ]; then
    . /worker/deploy/env.sh
fi

cd /worker/buildbot
echo -e "[user]\nname=OpenCV\nemail=opencv@local" > .gitconfig
buildbot-worker create-worker . $MASTER_HOSTNAME:$MASTER_PORT $WORKER_NAME $WORKER_PASS
/worker/deploy/sync.sh || exit 1
mkdir -p /worker/nginx
