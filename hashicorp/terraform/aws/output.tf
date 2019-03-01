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
