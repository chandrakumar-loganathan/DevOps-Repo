#!/bin/bash

# Assosiate the Elastic IP automatically

# NOTE:- Nneed to associate the `ec2:AssociateAddress` policy with the EC2 instance role.

mkdir ~/.aws
touch ~/.aws/credentials
chmod -R 777 ~/.aws
yum install -y wget aws-cli
echo "[default]" > ~/.aws/credentials
echo "region = <region>" >> ~/.aws/credentials

INSTANCE_ID=$(ec2-metadata -i | cut -d ' ' -f 2)
aws ec2 associate-address --instance-id $INSTANCE_ID  --allocation-id <elastic-ip-id>