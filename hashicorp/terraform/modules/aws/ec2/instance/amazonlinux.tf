variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {}
variable "name" {}
variable "vpc_id" {}
variable "security_groups" {
type = "list"
}

module "image" {
  source = "../ami/amazonlinux"
}

resource "aws_instance" "instance" {
  ami           = "${module.image.id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
#  subnet_id     = "${var.vpc_id}"
#  vpc_security_group_ids = ["${var.security_groups}"]
#  security_group_ids = ["${var.security_groups}"]

  tags {
    Name = "${var.name}"
  }
}

output "id" {
  value = "${aws_instance.instance.id}"
}

output "public_dns" {
  value = "${aws_instance.instance.public_dns}"
}

output "public_ip" {
  value = "${aws_instance.instance.public_ip}"
}
