#!/bin/sh

INSTANCE_IP=$1
KEYFILE=$2

# echo "sudo socat tcp4-listen:80,reuseaddr,fork TCP:localhost:3443" | \
ssh -v -R ${INSTANCE_IP}:3443:localhost:3443 ec2-user@${INSTANCE_IP} -i ${KEYFILE}