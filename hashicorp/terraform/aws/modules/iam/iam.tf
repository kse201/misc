variable "name" {
  default = "iam"
}

variable "users" {}
variable "policy" {}

resource "aws_iam_group" "group" {
  name = "${var.name}"
}

resource "aws_iam_user" "users" {
  count = "${length(split(",", var.users))}"
  name  = "${element(split(",", var.users), count.index)}"
}

resource "aws_iam_access_key" "keys" {
  count = "${length(split(",", var.users))}"
  user  = "${element(aws_iam_user.users.*.name, count.index)}"
}

resource "aws_iam_group_membership" "membership" {
  name  = "${var.name}"
  group = "${aws_iam_group.group.name}"
  users = ["${aws_iam_user.users.*.name}"]
}

output "users" {
  value = "${join(",", aws_iam_access_key.keys.*.user)}"
}

output "access_ids" {
  value = "${join(",", aws_iam_access_key.keys.*.id)}"
}

output "secret_keys" {
  value = "${join(",", aws_iam_access_key.keys.*.secret)}"
}
