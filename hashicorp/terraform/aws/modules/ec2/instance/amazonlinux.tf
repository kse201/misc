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
