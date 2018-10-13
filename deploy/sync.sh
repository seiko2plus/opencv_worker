#!/bin/bash

repos=("opencv" "opencv_contrib" "opencv_extra")
branches=("3.4" "master")

if [ ! -d /worker/sources ]; then
    mkdir -p /worker/sources/opencv && cd /worker/sources/opencv

    for repo in "${repos[@]}"; do
        git clone https://github.com/opencv/${repo}.git
    done
else
    for repo in "${repos[@]}"; do
        cd /worker/sources/opencv/${repo}
        for branch in "${branches[@]}"; do
            git checkout $branch
            git fetch origin
            git reset --hard origin/${branch}
            git clean -f -d
        done
    done
fi
