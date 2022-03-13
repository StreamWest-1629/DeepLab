#!/bin/sh

# TODO: change <bucketname>

goofys -f ${DEEPLAB_BUCKETNAME}:.jupyter/ /root/.jupyter/ &
goofys -f ${DEEPLAB_BUCKETNAME}:dataset/ /dataset/ &
python3 -m jupyter lab --port 5515 --ip=0.0.0.0 --allow-root
