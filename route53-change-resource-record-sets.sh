#!/bin/bash

VAR="catalogue cart user redis mongodb shipping payment mysql rabbitmq"

for i in $VAR ; do
  IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${i}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)
  sed -e "s/IPADDRESS/${IP}/" -e "s/DNS_NAME/${i}/" record >/tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id Z020952727UTZSZU8899Q --change-batch file:///tmp/record.json
done