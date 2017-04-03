variable "public_key" {}

variable "instance_type" {}

variable "key_name" {}

variable "name" {}

data "aws_ami" "amazonlinux" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key)}"
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
    Name = "${var.name}"
  }
}

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
