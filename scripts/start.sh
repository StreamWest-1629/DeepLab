#!/bin/sh

printenv GIT_CREDENTIALS > /root/.git-credentials
git config --global credential.helper "store --file /root/.git-credentials"
git config --global user.name "${GIT_USERNAME}"
git config --global user.email ${GIT_USERMAIL}

cd /src
goofys -f ${DEEPLAB_BUCKETNAME}:.jupyter/ /root/.jupyter/ &
goofys -f ${DEEPLAB_BUCKETNAME}:dataset/ /dataset/ &
python3 -m jupyter lab \
    --ContentsManager.allow_hidden=True \
    --port 5515 --ip=0.0.0.0 --allow-root
