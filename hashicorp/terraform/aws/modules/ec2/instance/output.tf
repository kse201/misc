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
