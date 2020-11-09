variable "region" {
  default = "ap-northeast-1"
}

variable "profile" {
  default = "default"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "private_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
