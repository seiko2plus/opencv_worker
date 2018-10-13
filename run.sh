#!/bin/bash
docker run -it --restart always -v $(pwd):/worker --name opencv-worker opencv-deps-worker
