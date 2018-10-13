#!/bin/bash
cd /worker/buildbot
echo -e "[user]\nname=OpenCV\nemail=opencv@local" > .gitconfig
buildbot-worker create-worker . [buildbot hostname]:9989 [workername] [workerpassword]
/worker/deploy/sync.sh || exit 1
mkdir -p /worker/nginx
