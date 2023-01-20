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

output "public_ip" {
  value = aws_instance.Server.public_ip
}
