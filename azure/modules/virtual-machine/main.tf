data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on          = [data.azurerm_resource_group.rg]
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
  depends_on           = [data.azurerm_virtual_network.vnet]
}

// A CRIAÇÃO DAS NICs OCORRE DE MANEIRA SEQUENCIAL, INDEPENDENTEMENTE DO SISTEMA OPERACIONAL DAS VMs
resource "azurerm_network_interface" "nic-sequencial" {
  count               = var.estrategia_de_implementacao == "sequencial" && var.sequencial_qtde_vms > 0 ? var.sequencial_qtde_vms : 0
  name                = "${var.sequencial_identical_vm_names}-nic-${count.index + 1}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on          = [data.azurerm_subnet.subnet]
  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_version    = var.nic_private_ip_address_version
    private_ip_address_allocation = var.nic_private_ip_address_allocation
    private_ip_address            = var.nic_private_ip_address_allocation == "Static" ? var.nic_private_ip_address : null
  }
}

// A CRIAÇÃO DAS VMs WINDOWS OCORRE DE MANEIRA SEQUENCIAL, UTILIZANDO COUNT
resource "azurerm_windows_virtual_machine" "vm-windows-sequencial" {
  count                 = var.estrategia_de_implementacao == "sequencial" && var.sequencial_qtde_vms > 0 && var.os_vms == "Windows" ? var.sequencial_qtde_vms : 0
  name                  = join("-", [var.sequencial_identical_vm_names, count.index + 1])
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = data.azurerm_resource_group.rg.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic-sequencial[count.index].id]
  depends_on            = [azurerm_network_interface.nic-sequencial]
  os_disk {
    caching              = var.os_disk["os_disk_caching"]
    storage_account_type = var.os_disk["os_disk_storage_account_type"]
  }
  source_image_reference {
    publisher = var.os_disk_source_image_reference["publisher"]
    offer     = var.os_disk_source_image_reference["offer"]
    sku       = var.os_disk_source_image_reference["sku"]
    version   = var.os_disk_source_image_reference["version"]
  }
}

// A CRIAÇÃO DAS VMs LINUX OCORRE DE MANEIRA SEQUENCIAL, UTILIZANDO COUNT
resource "azurerm_linux_virtual_machine" "vm-linux-sequencial" {
  count                           = var.estrategia_de_implementacao == "sequencial" && var.sequencial_qtde_vms > 0 && var.os_vms == "Linux" ? var.sequencial_qtde_vms : 0
  name                            = join("-", [var.sequencial_identical_vm_names, count.index + 1])
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = var.disable_password_authentication
  admin_password                  = var.disable_password_authentication == false ? var.admin_password : null
  network_interface_ids           = [azurerm_network_interface.nic-sequencial[count.index].id]
  depends_on                      = [azurerm_network_interface.nic-sequencial]
  os_disk {
    caching              = var.os_disk["os_disk_caching"]
    storage_account_type = var.os_disk["os_disk_storage_account_type"]
  }
  source_image_reference {
    publisher = var.os_disk_source_image_reference["publisher"]
    offer     = var.os_disk_source_image_reference["offer"]
    sku       = var.os_disk_source_image_reference["sku"]
    version   = var.os_disk_source_image_reference["version"]
  }
}

// A CRIAÇÃO DAS NICs OCORRE DE MANEIRA DINÂMICA, INDEPENDENTEMENTE DO SISTEMA OPERACIONAL DAS VMs
resource "azurerm_network_interface" "nic-dinamico" {
  for_each            = { for k, v in var.vms_dynamic : k => v if var.estrategia_de_implementacao == "dinamico" && var.vms_dynamic != {} }
  name                = join("-", [each.key, "nic"])
  location            = lookup(each.value, "nic_location", data.azurerm_resource_group.rg.location)
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on          = [data.azurerm_subnet.subnet, data.azurerm_public_ip.pip-windows, data.azurerm_public_ip.pip-linux]
  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_version    = lookup(each.value, "private_ip_version", var.nic_private_ip_address_version)
    private_ip_address_allocation = lookup(each.value, "private_ip_allocation", var.nic_private_ip_address_allocation)
    private_ip_address            = lookup(each.value, "private_ip_allocation", var.nic_private_ip_address_allocation) == "Static" ? each.value.nic_private_ip_address : null
    public_ip_address_id          = lookup(each.value, "public_ip", false) == true ? (var.os_vms == "Windows" ? data.azurerm_public_ip.pip-windows[join("-", [each.key, "pip"])].id : (var.os_vms == "Linux" ? data.azurerm_public_ip.pip-linux[join("-", [each.key, "pip"])].id : null)) : null
  }
}

// A CRIAÇÃO DOS PUBLIC IPs ACONTECE QUANDO AS VMS SÃO CRIADAS DE MANEIRA DINÂMICA E COM O SO WINDOWS
data "azurerm_public_ip" "pip-windows"{
  for_each = { for k, v in var.vms_dynamic : k => v if var.estrategia_de_implementacao == "dinamico" && var.vms_dynamic != {} && var.os_vms == "Windows" }
  name = join("-", [each.key, "pip"])
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on = [data.azurerm_resource_group.rg]
}

// A CRIAÇÃO DAS VMs WINDOWS OCORRE DE MANEIRA DINÂMICA, UTILIZANDO FOR_EACH
resource "azurerm_windows_virtual_machine" "vm-windows-dinamico" {
  for_each              = { for k, v in var.vms_dynamic : k => v if var.estrategia_de_implementacao == "dinamico" && var.vms_dynamic != {} && var.os_vms == "Windows" }
  name                  = each.key
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = lookup(each.value, "location", data.azurerm_resource_group.rg.location)
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = [azurerm_network_interface.nic-dinamico[each.key].id]
  depends_on            = [azurerm_network_interface.nic-dinamico]
  os_disk {
    caching              = lookup(each.value, "os_disk_caching", "ReadWrite")
    storage_account_type = lookup(each.value, "os_disk_storage_acct_type", "Standard_LRS")
  }
  source_image_reference {
    publisher = lookup(each.value, "os_image_publisher", "MicrosoftWindowsServer")
    offer     = lookup(each.value, "os_image_offer", "WindowsServer")
    sku       = lookup(each.value, "os_image_sku", "2019-Datacenter")
    version   = lookup(each.value, "os_image_version", "latest")
  }
}

// A CRIAÇÃO DOS PUBLIC IPs ACONTECE QUANDO AS VMS SÃO CRIADAS DE MANEIRA DINÂMICA E COM O SO LINUX
data "azurerm_public_ip" "pip-linux"{
  for_each = { for k, v in var.vms_dynamic : k => v if var.estrategia_de_implementacao == "dinamico" && var.vms_dynamic != {} && var.os_vms == "Linux" }
  name = join("-", [each.key, "pip"])
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on = [data.azurerm_resource_group.rg]
}

// A CRIAÇÃO DAS VMs LINUX OCORRE DE MANEIRA DINÂMICA, UTILIZANDO FOR_EACH
resource "azurerm_linux_virtual_machine" "vm-linux-dinamico" {
  for_each              = { for k, v in var.vms_dynamic : k => v if var.estrategia_de_implementacao == "dinamico" && var.vms_dynamic != {} && var.os_vms == "Linux" }
  name                  = each.key
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = lookup(each.value, "location", data.azurerm_resource_group.rg.location)
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = [azurerm_network_interface.nic-dinamico[each.key].id]
  depends_on            = [azurerm_network_interface.nic-dinamico]
  disable_password_authentication = var.disable_password_authentication
  os_disk {
    caching              = lookup(each.value, "os_disk_caching", "ReadWrite")
    storage_account_type = lookup(each.value, "os_disk_storage_acct_type", "Standard_LRS")
  }
  source_image_reference {
    publisher = lookup(each.value, "os_image_publisher", "Canonical")
    offer     = lookup(each.value, "os_image_offer", "UbuntuServer")
    sku       = lookup(each.value, "os_image_sku", "16.04-LTS")
    version   = lookup(each.value, "os_image_version", "latest")
  }
}