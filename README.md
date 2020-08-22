# Provisioning VPC, ECS and ALB using Terraform
https://github.com/dCode0/ecs-jenkins-terraform.git

Within the variable "port" {}...you can input your desired default port of Jenkins

With this template, you can simply create infrastructure using Terraform and AWS cloud as the provider. It consists of:
- Virtual Private Cloud (VPC) with 2 public subnets in 2 availability zones
- Elastic Container Service (ECS)- EC2 type.
- Application Load Balancer (ALB)

## How to create the infrastructure?
This example implies that you have already AWS account, with an S3 act as the remote backend of the tfstate file and Terraform CLI installed.
1. `https://github.com/dCode0/ecs-jenkins-terraform.git`
2. RUN `./deploy.sh`
You will be prompted to provide the following:
3. The name of AWS ECS cluster
   Enter a value: 

4. The name for ssh key, used for aws_launch_configuration
   Enter a value: 
   #It must be an existing key within your account

5. jenkins password

  Enter a value: #DO NOT USE "admin"

6. jenkins username
   Enter a value: #DO NOT USE "admin"
   
7. Select port for Jenkins server to run
  default = 8080
  #default value can be changed to your desired value.
}

#PS: From a security point of view, "admin" is a very weak password. 

Note: it can take about 5 minutes to provision all resources.

## How to delete the infrastructure?
1. Terminate instances (from console)
2. RUN `terraform destroy -auto-approve`

## Brief Description

Cluster is created using container instances (EC2 launch type, not Fargate!). 

In this example, verified module `vpc` is imported from Terraform Registry, other resources are created in relevant files.

In file `ecs.tf` we create:
  - cluster of container instances _container-cluster_
  - capacity provider, which is basically AWS Autoscaling group for EC2 instances. In this example managed scaling is enabled, Amazon ECS manages the scale-in and scale-out actions of the Auto Scaling group used when creating the capacity provider. I set target capacity to 85%, which will result in the Amazon EC2 instances in your Auto Scaling group being utilized for 85% and any instances not running any tasks will be scaled in.
  - task definition with family _jenkins-container-family_, volume and container definition is defined in the file container-def.json
  - service _web-service_, desired count is set to 3, which means there are 3 tasks will be running simultaneously on your cluster. There are two service scheduler strategies available: REPLICA and DAEMON, in this example REPLICA is used. Application load balancer is attached to this service, so the traffic can be distributed between those tasks.
  Note: The _binpack_ task placement strategy is used, which places tasks on available instances that have the least available amount of the cpu (specified with the field parameter). 

In file `asg.tf` we create:
  - launch configuration
  - security groups for EC2 instances
  - auto-scaling group. 

Note: in order to enable ECS managed scaling you need to enable `protect from scale in` from auto-scaling group.

In file `iam.tf` it'll create roles, which will help us to associate EC2 instances to clusters, and other tasks.

In file `alb.tf` it'll create Application Load Balancer with target groups, security group and listener. 


`output.tf` - Unfortunately,Terraform doesn't have the capacity to dynamically output the ip address of the ec2-instance created in our `asg.tf`, but the good news is that we have a hack for that.
The value for public IP associated with the autoscaling group instances was output by running this forLoop bash command within the `deploy.sh` - https://docs.aws.amazon.com/cli/latest/reference/autoscaling/describe-auto-scaling-groups.html.

