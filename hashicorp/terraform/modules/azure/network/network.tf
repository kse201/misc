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
  }
}

output "network_interface_id" {
  value = "${azurerm_network_interface.main.id}"
}
