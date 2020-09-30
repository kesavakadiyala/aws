#!bin/bash

for i in *.json; do
  echo $i;
  aws ec2 request-spot-fleet --spot-fleet-request-config file://$i
done