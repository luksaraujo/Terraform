output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "vnet_dns_servers" {
  value = azurerm_virtual_network.vnet.dns_servers
}

output "vnet_subnets" {
  value = azurerm_virtual_network.vnet.subnets
}

output "vnet_tags" {
  value = azurerm_virtual_network.vnet.tags
}