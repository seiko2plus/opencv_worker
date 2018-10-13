#!/bin/bash
if [ -d /worker/buildbot ]; then
	echo "Preparation step have been done. Remove buildbot dir to run it again"
else
	/worker/deploy/prepare_root.sh || exit 1
	su - buildbot -c /worker/deploy/prepare.sh || exit 1
fi

/worker/deploy/start_root.sh || exit 1
su - buildbot -c /worker/deploy/start.sh || exit 1