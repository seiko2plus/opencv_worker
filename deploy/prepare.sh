#!/bin/bash
cd /worker/buildbot
echo -e "[user]\nname=OpenCV\nemail=opencv@local" > .gitconfig
buildbot-worker create-worker . $WORKER_HOST:$WORKER_PORT $WORKER_NAME $WORKER_PASS
/worker/deploy/sync.sh || exit 1
mkdir -p /worker/nginx
