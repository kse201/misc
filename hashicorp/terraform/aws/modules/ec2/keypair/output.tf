output "name" {
  value = "${aws_key_pair.keypair.key_name}"
}

output "public_key" {
  value = "${aws_key_pair.keypair.public_key}"
}
