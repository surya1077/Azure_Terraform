output "network_interface_ids" {
  value = azurerm_network_interface.network_interface.id
}

output "id" {
  value = azurerm_public_ip.public_ip.id
}

output "ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "virtual_machine_ids" {
  value = azurerm_virtual_machine.virtual_machine.*.id
}

output "virtual_machine_names" {
  value = azurerm_virtual_machine.virtual_machine.*.name
}