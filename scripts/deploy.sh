#!/bin/sh

cd /src/terraform
terraform init \
    -backend-config=profile=${AWS_PROFILE} \
    -backend-config=bucket=${DEEPLAB_BUCKETNAME} \
    -backend-config=region=${AWS_REGION}

terraform apply \
    -var AWS_REGION=${AWS_REGION} \
    -var DEEPLAB_BUCKETNAME=${DEEPLAB_BUCKETNAME} \
    -var PROJECT_NAME=${PROJECT_NAME}
