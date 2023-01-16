data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = [var.vnet_address_space]
  dns_servers         = var.dns_servers != null ? var.dns_servers : null
  tags                = data.azurerm_resource_group.rg.tags
  depends_on          = [data.azurerm_resource_group.rg]
}

resource "azurerm_subnet" "snet" {
  for_each             = var.subnets
  resource_group_name  = data.azurerm_resource_group.rg.name
  name                 = each.key
  address_prefixes     = [each.value.address_prefix]
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints    = lookup(each.value, "service_endpoints", null)
  depends_on           = [azurerm_virtual_network.vnet]
  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", {}) != {} ? [1] : []
    content {
      name = lookup(each.value.delegation, "name", null)
      service_delegation {
        name    = lookup(each.value.delegation.service_delegation, "name", null)
        actions = lookup(each.value.delegation.service_delegation, "actions", null)
      }
    }
  }
}