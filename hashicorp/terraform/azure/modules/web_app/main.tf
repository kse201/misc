resource "azurerm_resource_group" "rm" {
  name     = "${var.resource_group_name}"
  location = "Japan East"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "service_plan"
  location            = "${azurerm_resource_group.rm.location}"
  resource_group_name = "${azurerm_resource_group.rm.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name = "${var.app_name}"
  location = "${azurerm_resource_group.rm.location}"
  resource_group_name = "${azurerm_resource_group.rm.name}"
  app_service_plan_id = "${azurerm_app_service_plan.plan.id}"

  site_config {
  }
}
