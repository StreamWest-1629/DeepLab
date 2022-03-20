#!/bin/sh

python3 -m pip install -r /src/requirements.txt

printenv GIT_CREDENTIALS > /root/.git-credentials
git config --global credential.helper "store --file /root/.git-credentials"
git config --global user.name "${GIT_USERNAME}"
git config --global user.email ${GIT_USERMAIL}

goofys -f --cheap \
    --stat-cache-ttl 30m \
    ${DEEPLAB_BUCKETNAME}:.jupyter/ /root/.jupyter/ &
goofys -f --cheap \
    --stat-cache-ttl 30m \
    ${DEEPLAB_BUCKETNAME}:dataset/ /dataset/
