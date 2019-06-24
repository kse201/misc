resource "azurerm_virtual_network" "vnet" {
  name                = "myVnet"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.location}"
  address_space       = ["10.0.0.0/16"]

  tags {
    environment = "terraform"
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "mySubnet"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_network_interface" "main" {
  //count               = "${var.count}"
//  name                = "name-${count.index + 1}"
  name                = "name"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.location}"

  ip_configuration {
    name                          = "network-configuration"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    public_ip_address_id          = "${azurerm_public_ip.public.id}"
  }
}

resource "azurerm_public_ip" "public" {
  //count               = "${var.count}"
  name                = "network-public-ip"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  allocation_method = "Static"
}
