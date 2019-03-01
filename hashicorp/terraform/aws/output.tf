output "instance_ids" {
  value = "${module.instance.ids}"
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
