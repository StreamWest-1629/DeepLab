#!/bin/sh

INSTANCE_IP=$1
KEYFILE=$2

ssh -N -v -R ${INSTANCE_IP}:3443:localhost:3443 ec2-user@${INSTANCE_IP} -i ${KEYFILE}