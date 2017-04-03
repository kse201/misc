variable "name" {}

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.name}"
  acl           = "private"
  force_destroy = true
}

output "bucket_id" {
  value = "${aws_s3_bucket.bucket.id}"
}

output "endpoint" {
  value = "${aws_s3_bucket.bucket.website_endpoint}"
}
