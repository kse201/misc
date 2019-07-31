data "azurerm_platform_image" "centos" {
  location ="${var.location}"
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
}

resource "azurerm_virtual_machine" "centos" {
  count               = "${var.count}"
  name                = "centos-virtual-machine"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "${data.azurerm_platform_image.centos.publisher}"
    offer     = "${data.azurerm_platform_image.centos.offer}"
    sku       = "${data.azurerm_platform_image.centos.sku}"
    version = "${data.azurerm_platform_image.centos.version}"

  }

  os_profile {
    computer_name  = "centos"
    admin_username = "${var.user}"
    admin_password = "${var.password}"
  }

  storage_os_disk {
    name              = "centos-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = "${file("~/.ssh/id_rsa.pub")}"
      path     = "/home/testadmin/.ssh/authorized_keys"
    }
  }

  tags {
    os = "centos"
  }
}
