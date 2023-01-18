resource_group_name = "lab-lucas-souza-tf-simple-infra-rg01"
resources_location  = "eastus2"

vnet_name          = "lab-lucas-souza-tf-simple-infra-vn01"
vnet_address_space = "192.168.0.0/16"

subnet_name             = "lab-lucas-souza-tf-simple-infra-sn01"
subnet_address_prefixes = "192.168.0.0/24"

vm_linux_nic_name   = "lab-lucas-souza-tf-simple-infra-nic01"
vm_windows_nic_name = "lab-lucas-souza-tf-simple-infra-nic02"

vm_linux_name           = "lab-ls-tf-vm01"
vm_linux_size           = "Standard_B2ms"
vm_linux_admin_username = "lucas"
vm_linux_admin_password = "P@assw0rd"

vm_windows_name           = "lab-ls-tf-vm02"
vm_windows_size           = "Standard_B2ms"
vm_windows_admin_username = "lucas"
vm_windows_admin_password = "P@assw0rd"

pip_linux_name   = "lab-lucas-souza-tf-simple-infra-pip01"
pip_windows_name = "lab-lucas-souza-tf-simple-infra-pip02"

nsg_rdp_name = "lab-lucas-souza-tf-simple-infra-nsg01"
nsg_ssh_name = "lab-lucas-souza-tf-simple-infra-nsg02"

rule_allow_rdp_name                  = "AllowRDP"
rule_allow_rdp_priority              = 1000
rule_allow_rdp_source_port_range     = "*"
rule_allow_rdp_source_address_prefix = "*"

rule_allow_ssh_name                  = "AllowSSH"
rule_allow_ssh_priority              = 1000
rule_allow_ssh_source_port_range     = "*"
rule_allow_ssh_source_address_prefix = "*"
