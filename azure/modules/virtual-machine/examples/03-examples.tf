# Cria duas máquinas virtuais Windows utilizando 'for_each', sendo:
# vm-frontend
# vm-backend

resource "azurerm_resource_group" "rg-01" {
  name     = var.rg_name
  location = var.rg_location
}

module "vnet" {
  source              = "../../virtual-network"
  resource_group_name = azurerm_resource_group.rg-01.name
  vnet_address_space  = "192.168.0.0/16"
  vnet_name           = "lab-lucas-souza-tf-simple-infra-vn01"
  depends_on          = [azurerm_resource_group.rg-01]
  subnets = {
    lab-lucas-souza-tf-simple-infra-sn01 = {
      address_prefix = "192.168.0.0/24"
    }
  }
}

module "vm-windows-dinamico" {
  source                      = "../"
  resource_group_name         = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao = "dinamico"
  vnet_name                   = module.vnet.vnet_name
  subnet_name                 = "lab-lucas-souza-tf-simple-infra-sn01"
  os_vms                      = "Windows"
  depends_on                  = [module.vnet]
  vms_dynamic = {
    "vm-frontend" = { size = "Standard_B1ms", admin_username = "lukita", admin_password = var.admin_password },
    "vm-backend"  = { size = "Standard_DS1_v2", admin_username = "lucas", admin_password = var.admin_password }
  }
}