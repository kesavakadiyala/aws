#!bin/bash

#for i in *.json; do
#  echo $i;
#  aws ec2 request-spot-fleet --spot-fleet-request-config file://$i
#done

if [ -z "$1" ]; then
  echo "Provide input json file"
  exit 1
fi

aws ec2 request-spot-fleet --spot-fleet-request-config file://$i
