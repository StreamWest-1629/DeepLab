#!/bin/sh

aws cloudformation deploy \
    --template /src/aws/template.yaml \
    --stack-name ${DEPLOY_STACKNAME} \
    --parameter-overrides BucketName=${DEEPLAB_BUCKETNAME}
