variable "name" {}

variable "public_key" {}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.name}"
  public_key = "${var.public_key}"
}

output "name" {
  value = "${aws_key_pair.keypair.key_name}"
}

output "public_key" {
  value = "${aws_key_pair.keypair.public_key}"
}
