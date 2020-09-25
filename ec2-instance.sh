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
    if [[ "$imageId" == "" ]] && [[ "$numberOfInstances" == "" ]] && [[ "$type" == "" ]] && [[ "$securityGroupId" == "" ]];then
      echo "None of the field shouldn't be empty."
      exit 1;
    elif [ $numberOfInstances -eq  0 ]; then
      echo "Minimum Number of instance must be greater than zero"
      exit 1;
    fi
    aws ec2 run-instances --image-id $imageId --count $numberOfInstances --instance-type $type --security-group-ids $securityGroupId
  ;;

  describe)
    echo -e "Please select on which bases you want to describe: \n1. Image Id\n2. Instance Id\n3. Tag and Value: "
    echo -n "Enter Option: "
    read input
    if [[ $input -ne 1 ]] && [[ $input -ne 2 ]] && [[ $input -ne 3 ]];then
      echo -e "Please select proper input with in mentioned numbers."
      exit 2;
    fi
    case $input in
      1)
        echo -n "Enter Image Id (If multiple , seperated): "
        read imageId
        aws ec2 describe-instances --filters "Name=image-id,Values=$imageId"
      ;;
      2)
        echo -n "Enter Instance Id (If multiple , seperated): "
        read instanceId
        aws ec2 describe-instances --filters "Name=image-id,Values=$instanceId"
      ;;
      3)
        echo -n "Enter Tag Name: "
        read tag
        echo -n "Enter Value of tag: "
        read value
        aws ec2 describe-instances --filters "Name=tag:$tag,Values=$value"
      ;;
      *)
        echo -e "\e[1;31mPlease mention proper input for $0 script. \nUsage: sh Project.sh create|describe|terminate\e[0m"
      ;;
    esac

  ;;

  terminate)
    echo -n "Instance Id: "
    read instanceId
    aws ec2 terminate-instances --instance-ids $instanceId
  ;;

  stop)
    echo -n "Instance Id: "
    read instanceId
    aws ec2 stop-instances --instance-ids $instanceId
  ;;
#  tag)
#    aws ec2 create-tags --resources i-5203422c --tags Key=Name,Value=MyInstance
#  ;;

  *)
    echo -e "\e[1;31mPlease mention proper input for $0 script. \nUsage: sh Project.sh create|describe|terminate\e[0m"
  ;;

esac