#!/bin/sh

python3 -m pip install -r /src/requirements.txt

git config --global credential.helper "store --file /root/.git-credentials"

goofys -f --cheap \
    --stat-cache-ttl 30m \
    ${DEEPLAB_BUCKETNAME}:.jupyter/ /root/.jupyter/ &
goofys -f --cheap \
    --stat-cache-ttl 30m \
    ${DEEPLAB_BUCKETNAME}:dataset/ /dataset/ &
(
    echo launching jupyter lab...
    # wait for goofys mounting
    sleep 5

    # launch jupyter lab
    python3 -m jupyter lab \
        --ContentsManager.allow_hidden=True \
        --port 5515 --ip=0.0.0.0 --allow-root
)
