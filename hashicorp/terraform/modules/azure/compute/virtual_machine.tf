variable "resource_group" {}
variable "location" {}
variable "network_interface_id" {}

variable "prefix" {
  default = "azure"
}

variable "user" {
    default = "testadmin"
}
variable "password" {
    default = "testpass"
}

variable "vm_size" {
  default = "Standard_DS1_V2"
}

resource "azurerm_virtual_machine" "ubuntu" {
  name                = "${var.prefix}-virtual-machine"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  network_interface_ids = ["${var.network_interface_id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "ubuntu"
    admin_username = "${var.user}"
    admin_password = "${var.password}"
  }

  storage_os_disk {
      name = "${var.prefix}-disk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type ="Standard_LRS"
  }

  os_profile_linux_config {
      disable_password_authentication = true
    ssh_keys {
      key_data = "${file("~/.ssh/id_rsa.pub")}"
      path = "/home/testadmin/.ssh/authorized_keys"
    }
  }

  tags {
    os = "ubuntu"
  }
}
