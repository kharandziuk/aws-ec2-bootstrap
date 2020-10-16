terraform {
  required_version = ">= 0.12"
}

# resource "tls_private_key" "example" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "deploy" {
#   key_name   = "key related to main object"
#   public_key = file("${path.module}/files/key_rsa.pub")
# }

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
}

# data "aws_ami" "ubuntu" {
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["ami-0474863011a7d1541"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   owners = [var.amiowners]
# }

resource "aws_instance" "example" {
  ami = "ami-0474863011a7d1541"
  # ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # instance_type = "t2.micro"
  # key_name = aws_key_pair.deploy.key_name

  tags = {
    Purpose = "for prototype of docker-compose and ami"
  }

  vpc_security_group_ids = [aws_security_group.main.id]
}

locals {
  ansible_command_engine = "ansible-playbook -i ${aws_instance.example.public_ip}, --user root --private-key files/key_rsa ../../playbook.yml"
}



