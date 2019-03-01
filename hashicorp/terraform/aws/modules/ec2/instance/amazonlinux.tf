variable "instance_type" {
  default = "t2.micro"
}

variable "count" {
  default = 1
}

variable "key_name" {}
variable "name" {}
variable "vpc_id" {}
variable "security_group" {}

module "image" {
  source = "../ami/amazonlinux"
}

resource "aws_instance" "instance" {
  count                  = "${var.count}"
  ami                    = "${module.image.id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  subnet_id              = "${var.vpc_id}"
  vpc_security_group_ids = ["${var.security_group}"]

  #  security_groups = ["${var.security_group}"]

  tags {
    Name = "${var.name}-${count.index + 1}"
  }
}

// output "id" {
//   value = "${aws_instance.instance.id}"
// }

output "ids" {
  value = "${aws_instance.instance.*.id}"
}

output "public_dns" {
  //value = "${aws_instance.instance.public_dns}"
  value = "${aws_instance.instance.*.public_dns}"
}

output "public_ips" {
  //value = "${aws_instance.instance.public_ip}"
  value = "${aws_instance.instance.*.public_ip}"
}
