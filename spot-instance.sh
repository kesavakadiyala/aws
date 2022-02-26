#!/bin/bash

if [ -n "$1" ] && [ -n "$2" ]; then
aws ec2 request-spot-instances --spot-price "0.0035" --instance-count 1 --type "persistent" --launch-specification file://$1  --tag-specification 'ResourceType=spot-instances-request,Tags=[{Key=Name,Value='$2'}]'
else
echo -e "Input for script is missnig! \nExample: sh spot-instance.sh specifications.json tagname"
exit 1
fi
