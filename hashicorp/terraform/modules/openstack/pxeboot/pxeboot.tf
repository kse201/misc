# identity ----------------------------------------
variable "os_username" {}

variable "os_password" {}
variable "os_tenant_name" {}
variable "os_auth_url" {}
variable "os_domain_name" {}
variable "region" {}

# params ----------------------------------------
variable "security_group" {}

variable "flavor_name" {}
variable "instance_name" {}
variable "keypair_name" {}
variable "keypair_pub_path" {}
variable "deploy_net" {}

# provider ----------------------------------------

provider "openstack" {
  user_name   = "${var.os_username}"
  password    = "${var.os_password}"
  tenant_name = "${var.os_tenant_name}"
  domain_name = "${var.os_domain_name}"
  auth_url    = "${var.os_auth_url}"
}

# data ----------------------------------------

data "openstack_networking_network_v2" "deploy" {
  name = "${var.deploy_net}"
}

# resource ----------------------------------------

resource "openstack_images_image_v2" "pxeboot" {
  name             = "PXEBoot"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  local_file_path  = "./pxeboot.img"
}

resource "openstack_compute_keypair_v2" "keypair" {
  name       = "${var.keypair_name}"
  public_key = "${file("${var.keypair_pub_path}")}"
}

resource "openstack_networking_port_v2" "deploy_port" {
  name           = "pxeboot_deploy_port"
  network_id     = "${data.openstack_networking_network_v2.deploy.id}"
  admin_state_up = true
}

resource "openstack_compute_instance_v2" "instance" {
  name            = "${var.instance_name}"
  image_id        = "${openstack_images_image_v2.pxeboot.id}"
  flavor_name     = "${var.flavor_name}"
  security_groups = ["${var.security_group}"]
  key_pair        = "${openstack_compute_keypair_v2.keypair.name}"

  network {
    port = "${openstack_networking_port_v2.deploy_port.id}"
  }
}

# output ----------------------------------------

output "pxeboot_image_id" {
  value = "${openstack_images_image_v2.pxeboot.id}"
}

output "keypair_name" {
  value = "${openstack_compute_keypair_v2.keypair.name}"
}

output "deploy_port_id" {
  value = "${openstack_networking_port_v2.deploy_port.id}"
}

output "pxeboot_instance_id" {
  value = "${openstack_compute_instance_v2.instance.id}"
}
