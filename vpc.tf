module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "2.38.0"
  name           = "test_ecs_provisioning"
  cidr           = "10.0.0.0/16"
  azs            = var.azs
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  tags = {
    "env"       = "dev"
    "createdBy" = "mkerimova"
  }

}

resource "aws_vpc_ipv4_cidr_block_association" "jenkins_ip" {
  vpc_id     = data.aws_vpc.main.id
  cidr_block = "172.2.0.0/16"
}

variable "azs" {
  description = "Choose az"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

data "aws_vpc" "main" {
  id = module.vpc.vpc_id
}
