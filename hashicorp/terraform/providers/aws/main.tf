variable "region" {
  default = "ap-northeast-1"
}

provider "aws" {
  region = "${var.region}"
}

module "keypair" {
  source = "../../modules/aws/ec2/keypair"

  name       = "vagrant"
  public_key = "${file("./id_rsa.pub")}"
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

resource "aws_security_group" "icmp" {
  name        = "icmp"
  description = "Allow ICMP"

  vpc_id = "${module.vpc.id}"

  tags {
    Name = "ICMP"
  }

  ingress {
    protocol = "icmp"
    from_port   = 0
    to_port     = 16
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "icmp"
    from_port   = 0
    to_port     = 16
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "instance" {
  source = "../../modules/aws/ec2/instance"

  name     = "helloworld"
  key_name = "${module.keypair.name}"
  vpc_id   = "${module.vpc.subnet_id}"
  security_groups = ["${aws_security_group.ssh.id}", "${aws_security_group.icmp.id}"]
}

output "instance_id" {
  value = "${module.instance.id}"
}

output "public_dns" {
  value = "${module.instance.public_dns}"
}
