#!/bin/bash
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Settings
if [ ! -f deploy/env.sh ]; then
  cat > deploy/env.sh <<EOF
export APP_UID=$UID
export APP_GID=$GROUPS
export WORKER_HOST=xxx
export WORKER_PORT=9989
export WORKER_NAME=xxx
export WORKER_PASS=XXX
EOF
fi

# Docker image
docker build -t opencv_worker_image deploy

echo "Check settings on deploy/env.sh before run run.sh"