output "region" {
  value = "${var.region}"
}

output "profile" {
  value = "${var.profile}"
}

output "instance_type" {
  value = "${var.instance_type}"
}

output "private_key_path" {
  value = "${var.private_key_path}"
}

output "sec_group_id" {
  value = "${aws_security_group.ssh.id}"
}

output "amazonlinux_ami_id" {
  value = "${module.image.id}"
}

output "keypair_name" {
  value = "${module.keypair.name}"
}

output "subnet_id" {
  value = "${module.vpc.subnet_id}"
}
