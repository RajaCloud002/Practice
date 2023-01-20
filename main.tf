provider "aws" {
  region = "us-west-2"
}

variable "instance_type" {
  type = string
}

locals {
  name = "raja"
}
resource "aws_instance" "Server" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = var.instance_type

  tags = {
    Name = "VM-${local.name}"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
output "public_ip" {
  value = aws_instance.Server.public_ip
}
