#!/bin/sh

# TODO: change <bucketname>

goofys <bucketname>:.jupyter/ /root/.jupyter/ &
goofys <bucketname>:dataset/ /dataset/ &
python3 -m jupyter lab --ip=0.0.0.0 --allow-root
