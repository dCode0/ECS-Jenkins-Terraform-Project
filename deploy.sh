#! /bin/bash
terraform init
terraform apply -auto-approve
for ID in $(aws autoscaling describe-auto-scaling-instances --region us-east-1 --query AutoScalingInstances[].InstanceId --output text);
do
aws ec2 describe-instances --instance-ids $ID --region us-east-1 --query Reservations[].Instances[].PublicIpAddress --output text
done
