variable "resource_group_name" {}
variable "location" {}
variable "prefix" {
    default = "network"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "myVnet"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  address_space       = ["10.0.0.0/16"]

  tags {
    environment = "terraform"
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "mySubnet"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_network_interface" "main" {
  name                = "name"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  ip_configuration {
      name ="${var.prefix}-configuration"
      private_ip_address_allocation = "Dynamic"
      subnet_id = "${azurerm_subnet.subnet.id}"
  public_ip_address_id = "${azurerm_public_ip.public.id}"
  }
}

resource "azurerm_public_ip" "public" {
    name = "${var.prefix}-public-ip"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  allocation_method = "Static"
}

output "network_interface_id" {
  value = "${azurerm_network_interface.main.id}"
}
output "network_interface_addr" {
  value = "${azurerm_public_ip.public.ip_address}"
}
