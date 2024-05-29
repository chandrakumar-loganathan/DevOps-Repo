#!/bin/bash

# For arm64 type machines
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/arm64/latest/amazon-cloudwatch-agent.rpm 
rpm -U ./amazon-cloudwatch-agent.rpm
cp <cloudwatch_agent_path> /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
#start the cludwatch agent in background
/opt/aws/amazon-cloudwatch-agent/bin/start-amazon-cloudwatch-agent & 

# Cloudwatch agent configuration for several type of Architecture
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/download-cloudwatch-agent-commandline.html