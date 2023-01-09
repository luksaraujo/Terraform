data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnets
  name                = each.key
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = [each.value.address_space]
  dns_servers         = [lookup(each.value, "dns_servers", null)]
  dynamic "subnet" {
    for_each = lookup(each.value, "subnet", {}) != {} ? [1] : []
    content {
      name           = lookup(each.value.subnet, "name", null)
      address_prefix = lookup(each.value.subnet, "address_prefix", null)
      security_group = lookup(each.value.subnet, "security_group", null)
    }
  }
  depends_on = [data.azurerm_resource_group.rg]
}