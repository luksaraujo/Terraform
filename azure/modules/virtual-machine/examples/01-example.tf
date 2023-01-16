# Cria três máquinas virtuais Windows utilizando 'Count', sendo:
# vm-windows-01
# vm-windows-02
# vm-windows-03

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

module "vm-windows-sequencial" {
  source                        = "../"
  resource_group_name           = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao   = "sequencial"
  vnet_name                     = module.vnet.vnet_name
  sequencial_identical_vm_names = "vm-win-lab"
  sequencial_qtde_vms           = 3
  os_vms                        = "Windows"
  vm_size                       = "Standard_B1ms"
  admin_username                = "lucas"
  admin_password                = "P@assw0rd"
  subnet_name                   = "lab-lucas-souza-tf-simple-infra-sn01"
  depends_on                    = [module.vnet]
  os_disk = {
    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "Standard_LRS"
  }
  os_disk_source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}