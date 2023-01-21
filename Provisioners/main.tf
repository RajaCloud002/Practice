locals {
  name = "raja"
}

data "aws_vpc" "my_vpc" {
  id = "vpc-0e3c8ad080403d8e2"
}

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}
resource "aws_key_pair" "key" {
  key_name   = "aws"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCQH+/OB/Vc50gYyetVVLzb+N47RRStswogUvZSAw8/7ZhE6zxORlH221I9Lb4huSs7OlCAg865MIXIllNxFI2D4gmFA8WgeGhT6eNTd03LLp7a74uFv0rRMq5f2QMrNJB84uxDenS2ET5rquLFLGJAP3/Lzw+mcIUu9demxN7xi8bkEQcyiHb8zQUPpIo52IISYEUeILmTSn3uOa7R7SC6Cv8WEV3bNE/0Km4GmlNCT9zeXT7Pu0ViMz6UvTpjAQLs6OJQOtuUfmdrlYohaTBBtw4wpqRO48pwQ8oce1d1J3OhAkRUoJ/HXiQzDy0jU6LwtBHsAOfHpRlOf+MfQ1ch rsa-key-20221111"
  tags = {
    Name = "AWS-Key"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "allow HTTP"
  description = "Allow HTTP inbound traffic"
  vpc_id = data.aws_vpc.my_vpc.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "my_SG"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = []
  security_group_id = "aws_security_group.my_sg.id"
}
resource "aws_instance" "Server" {
  ami                    = "ami-005e54dee72cc1d00" # us-west-2
  instance_type          = "t2.micro"
  key_name               = "aws"
  vpc_security_group_ids = ["aws_security_group.my_sg.id"]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "VM-${local.name}"
  }
}

