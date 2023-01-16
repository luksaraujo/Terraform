resource "azurerm_resource_group" "rg-01" {
  name     = var.rg_name
  location = var.rg_location
}