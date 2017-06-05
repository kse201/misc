variable "region" {
  default = "ap-northeast-1"
}

provider "aws" {
  region = "${var.region}"
}

module "keypair" {
  source = "../../modules/aws/ec2/keypair"

  name       = "vagrant"
  public_key = "${file("./id_rsa_ec2.pub")}"
}

module "vpc" {
  source = "../../modules/aws/vpc"

  name       = "develop"
  cidr_block = "172.1.1.0/24"
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH"

  vpc_id = "${module.vpc.id}"

  tags {
    Name = "SSH"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "instance" {
  source = "../../modules/aws/ec2/instance"

  name            = "helloworld"
  key_name        = "${module.keypair.name}"
  vpc_id          = "${module.vpc.subnet_id}"
  security_group = "${aws_security_group.ssh.id}"
}

output "instance_id" {
  value = "${module.instance.id}"
}

output "public_dns" {
  value = "${module.instance.public_dns}"
}

output "ingress_value" {
  value = "${aws_security_group.ssh.ingress}"
}

output "egress_value" {
  value = "${aws_security_group.ssh.egress}"
}

terraform {
  backend "s3" {
    bucket = "kse201"
    key    = "terraform/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
