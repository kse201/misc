variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "keypair_pub" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "instance_type" {
  default ="t2.micro"
}

# ------------------------------------------------------------

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

data "aws_ami" "amazonlinux" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "tf_test-key"
  public_key = "${var.keypair_pub}"
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH"

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

resource "aws_instance" "instance" {
  ami             = "${data.aws_ami.amazonlinux.id}"
  instance_type   = "${var.instance_type}"
  key_name        = "${aws_key_pair.keypair.key_name}"
  security_groups = ["default", "${aws_security_group.ssh.name}"]

  tags {
    Name = "HelloWorld"
  }
}

# ------------------------------------------------------------

output "instance_id" {
  value = "${aws_instance.instance.id}"
}

output "public_dns" {
  value = "${aws_instance.instance.public_dns}"
}

output "public_ip" {
  value = "${aws_instance.instance.public_ip}"
}

output "keypair_fingerprint" {
  value = "${aws_key_pair.keypair.fingerprint}"
}
