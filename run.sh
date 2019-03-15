#!/bin/bash
docker run -it --restart always -v $(pwd):/worker --name opencv_worker opencv_worker_image
