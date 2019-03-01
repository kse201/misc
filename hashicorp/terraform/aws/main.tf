module "keypair" {
  source = "./modules/ec2/keypair"

  name       = "vagrant"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

module "vpc" {
  source = "./modules/vpc"

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
  source = "./modules/ec2/instance"

  name           = "helloworld"
  key_name       = "${module.keypair.name}"
  vpc_id         = "${module.vpc.subnet_id}"
  security_group = "${aws_security_group.ssh.id}"
  instance_type  = "t2.micro"
}
