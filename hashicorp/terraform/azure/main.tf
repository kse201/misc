resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "Japan East"
}

module "network" {
  source = "./modules/network"

  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
}

module "compute" {
  source = "./modules/compute"

  resource_group       = "${azurerm_resource_group.rg.name}"
  location             = "${azurerm_resource_group.rg.location}"
  network_interface_id = "${module.network.network_interface_id}"
}
