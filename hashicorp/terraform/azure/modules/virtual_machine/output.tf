output "network_interface_addr" {
  value = "${azurerm_public_ip.public.ip_address}"
}
