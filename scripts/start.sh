#!/bin/sh

goofys -f ${DEEPLAB_BUCKETNAME}:.jupyter/ /root/.jupyter/ &
goofys -f ${DEEPLAB_BUCKETNAME}:dataset/ /dataset/ &
python3 -m jupyter lab \
    --ContentsManager.allow_hidden=True \
    --port 5515 --ip=0.0.0.0 --allow-root
