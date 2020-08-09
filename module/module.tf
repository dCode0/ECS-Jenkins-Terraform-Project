module "ecs_cluster" {
  source = "infrablocks/ecs-cluster/aws"
  version = "0.2.5"

  region = "us-east-1"
  vpc_id = "vpc-fb7dc365"
  subnet_ids = "subnet-eb32c271,subnet-64872d1f"

  component = "important-component"
  deployment_identifier = "production"

  cluster_name = "services"
  cluster_instance_ssh_public_key_path = "~/.ssh/id_rsa.pub"
  cluster_instance_type = "t2.small"

  cluster_minimum_size = 1
  cluster_maximum_size = 1
  cluster_desired_capacity = 1
}