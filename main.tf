provider "aws" {
  region  = "us-east-1"
  version = "~> 2.63"
}


terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-mayaki" #INPUT AN EXISTING BUCKET NAME IN THE SAME REGION
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
