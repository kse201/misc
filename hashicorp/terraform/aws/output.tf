# output "instance_ids" {
#   value = "${module.instance.ids}"
# }

# output "public_dns" {
#   value = "${module.instance.public_dns}"
# }
# 
# output "ingress_value" {
#   value = "${aws_security_group.ssh.ingress}"
# }

# output "egress_value" {
#   value = "${aws_security_group.ssh.egress}"
# }

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
