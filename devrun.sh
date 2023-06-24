#!/bin/bash

docker run -it --rm --name flask -v $(pwd)/app:/app -e GUNICORN_CMD_ARGS="--bind=0.0.0.0 --workers=8 --reload" -p 8000:80 naxreo/nginx:flask bash
## run
# export GUNICORN_CMD_ARGS="--bind=0.0.0.0 --workers=8 --reload"
# gunicorn -b unix:/tmp/gunicorn.sock app:app & nginx -g 'daemon off;'
