#!bin/bash

case $1 in
  create|request)
    echo -n "Enter image-id: "
    read imageId
    echo -n "Number of Instances: "
    read numberOfInstances
    echo -n "Instance Type [EX: t2.micro]: "
    read type
    echo -n "Security Group Id: "
    read securityGroupId
    aws ec2 run-instances --image-id $imageId --count $numberOfInstances --instance-type $type --security-group-ids $securityGroupId
  ;;

  describe)
    echo -n "Enter image-id(If multiple , seperated): "
    read imageId
    aws ec2 describe-instances --filters "Name=image-id,Values=$imageId"
  ;;

  terminate)
    echo -n "Instance Id: "
    read instanceId
    aws ec2 terminate-instances --instance-ids $instanceId
  ;;

#  tag)
#    aws ec2 create-tags --resources i-5203422c --tags Key=Name,Value=MyInstance
#  ;;

  *)
    echo -e "\e[1;31mPlease mention proper input for $0 script. \nUsage: sh Project.sh create|describe|terminate\e[0m"
  ;;

esac