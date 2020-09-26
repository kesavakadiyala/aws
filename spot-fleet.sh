#!bin/bash

if [ -z "$1" ]; then
  echo -e "\e[1;31mPlease provide json file as input \nUsage: sh $0 specifications.json\e[0m";
  exit 1;
fi

aws ec2 request-spot-fleet --spot-fleet-request-config file://$1