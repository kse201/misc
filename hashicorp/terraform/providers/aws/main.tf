variable "region" {
  default = "ap-northeast-1"
}

provider "aws" {
  region = "${var.region}"
}

module "tf_bucket" {
  source = "../../modules/aws/s3/tf_bucket"

  name = "kse-tfbucket"
}

terraform {
  backend "s3" {
    bucket = "kse-tfbucket"
    key    = "key"
    region = "ap-northeast-1"
  }
}
