#!bin/bash

#Function for printing input requests
Print(){
  echo -n -e "\e[33m$1\e[0m";
}
#Function for printing Failed Messsages
Print_Fail(){
  echo -e "\e[1;31m$1\e[0m";
}

#Main Program
echo -e "Please select which operation you want to perform: \n1. Create/request\n2. Describe\n3. Terminate \n4. Stop \n5. Start"
Print "Enter Option: "
read operation
#Checking input condition
if [[ $operation -ne 1 ]] && [[ $operation -ne 2 ]] && [[ $operation -ne 3 ]] && [[ $operation -ne 4 ]] && [[ $operation -ne 5 ]];then
   Print_Fail "Please select proper input with in mentioned numbers."
   exit 1;
fi

case $operation in
  #Creating ec2 instance
  1)
    Print "Enter image-id: "
    read imageId
    Print "Number of Instances: "
    read numberOfInstances
    Print "Instance Type [EX: t2.micro]: "
    read type
    Print "Security Group Id: "
    read securityGroupId
    Print "Enter Tag Name and Value"
    Print "Tag Name: "
    read tagName
    Print "Tag Value"
    read tagValue
    if [[ "$imageId" == "" ]] && [[ "$numberOfInstances" == "" ]] && [[ "$type" == "" ]] && [[ "$securityGroupId" == "" ]];then
      Print_Fail "None of the field shouldn't be empty."
      exit 1;
    elif [ $numberOfInstances -eq  0 ]; then
      Print_Fail "Minimum Number of instance must be greater than zero"
      exit 1;
    fi
    aws ec2 run-instances --image-id $imageId --count $numberOfInstances --instance-type $type --security-group-ids $securityGroupId --tag-specifications "ResourceType=instance,Tags=[{Key=$tagName,Value=$tagValue}]"
  ;;

  #Describing ec2 instance
  2)
    echo -e "Please select on which bases you want to describe: \n1. Image Id\n2. Instance Id\n3. Tag and Value "
    Print "Enter Option: "
    read input
    #Checking input condition
    if [[ $input -ne 1 ]] && [[ $input -ne 2 ]] && [[ $input -ne 3 ]];then
      Print_Fail "Please select proper input with in mentioned numbers."
      exit 2;
    fi
    #Requesting input based on above selection and Describing accordingly
    case $input in
      1)
        Print "Enter Image Id (If multiple , seperated): "
        read imageId
        aws ec2 describe-instances --filters "Name=image-id,Values=$imageId"
      ;;
      2)
        Print "Enter Instance Id (If multiple , seperated): "
        read instanceId
        aws ec2 describe-instances --filters "Name=image-id,Values=$instanceId"
      ;;
      3)
        Print "Enter Tag Name: "
        read tag
        Print "Enter Value of tag: "
        read value
        aws ec2 describe-instances --filters "Name=tag:$tag,Values=$value"
      ;;
      *)
        Print_Fail "Please mention proper input for $0 script. \nUsage: sh Project.sh create|describe|terminate"
      ;;
    esac
  ;;

  #Terminating ec2 instances
  3)
    Print "Instance Id: "
    read instanceId
    aws ec2 terminate-instances --instance-ids $instanceId
  ;;

  #Stopping ec2 instances
  4)
    Print "Instance Id: "
    read instanceId
    aws ec2 stop-instances --instance-ids $instanceId
  ;;

  #Starting ec2 instances
  5)
    Print "Instance Id: "
    read instanceId
    aws ec2 start-instances --instance-ids $instanceId
  ;;

  *)
    Print_Fail "Please enter proper input within the mentioned range."
  ;;

esac