variable "aws_access_key" {
  description = "Access key to your AWS account "
}

variable "aws_secret_key" {
  description = "Secret key to your AWS account "
}

variable "aws_region" {
  default     = "eu-central-1"
  description = "AWS region"
}
resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


module "instance" {
  description = "test instance"
  source      = "../"
  public_key = "${tls_private_key.default.public_key_openssh}"
}
