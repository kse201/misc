resource "aws_key_pair" "keypair" {
  key_name   = "${var.name}"
  public_key = "${var.public_key}"
}
