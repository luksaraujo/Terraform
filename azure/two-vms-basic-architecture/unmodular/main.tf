resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resources_location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "subnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = var.subnet_name
  address_prefixes     = [var.subnet_address_prefixes]
}

resource "azurerm_network_interface" "nic_vm_linux" {
  name                = var.vm_linux_nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_linux.id
  }
}

resource "azurerm_network_interface" "nic_vm_windows" {
  name                = var.vm_windows_nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_windows.id
  }
}

resource "azurerm_windows_virtual_machine" "vm_windows" {
  name                  = var.vm_windows_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.vm_windows_size
  admin_username        = var.vm_windows_admin_username
  admin_password        = var.vm_windows_admin_password
  network_interface_ids = [azurerm_network_interface.nic_vm_windows.id, ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "vm_linux" {
  name                            = var.vm_linux_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_linux_size
  admin_username                  = var.vm_linux_admin_username
  admin_password                  = var.vm_linux_admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic_vm_linux.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "pip_linux" {
  name                = var.pip_linux_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "pip_windows" {
  name                = var.pip_windows_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "nsg_rdp" {
  name                = var.nsg_rdp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "nsg_ssh" {
  name                = var.nsg_ssh_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc_rdp" {
  network_interface_id      = azurerm_network_interface.nic_vm_windows.id
  network_security_group_id = azurerm_network_security_group.nsg_rdp.id
}

resource "azurerm_network_security_rule" "nsg_rule_rdp_allow" {
  name                        = var.rule_allow_rdp_name
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg_rdp.name
  priority                    = var.rule_allow_rdp_priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = var.rule_allow_rdp_source_port_range
  destination_port_range      = 3389
  source_address_prefix       = var.rule_allow_rdp_source_address_prefix
  destination_address_prefix  = "*"
}