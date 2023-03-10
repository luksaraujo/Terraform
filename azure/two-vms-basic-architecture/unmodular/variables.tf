variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group que conterá os recursos da solução proposta"
}

variable "resources_location" {
  type        = string
  description = "Localização onde os recursos serão criados"
}

variable "vnet_name" {
  type        = string
  description = "Nome da VNet que conterá as duas VMs"
}

variable "vnet_address_space" {
  type        = any
  description = "Address Space da VNet que conterá as VMs da arquitetura proposta"
}

variable "subnet_name" {
  type        = string
  description = "Nome da Subnet que conterá as duas máquinas virtuais"
}

variable "subnet_address_prefixes" {
  type        = any
  description = "Address Prefixes da Subnet que conterá as VMs da arquitetura proposta"
}

variable "vm_linux_nic_name" {
  type        = string
  description = "Nome da NIC da máquina virtual Linux."
}

variable "vm_linux_name" {
  type        = string
  description = "Nome da VM Linux"
}

variable "vm_linux_size" {
  type        = string
  description = "Size da VM Linux"
}

variable "vm_linux_admin_username" {
  type        = string
  description = "Nome de usuário do admin da máquina Linux"
}

variable "vm_linux_admin_password" {
  type        = string
  description = "Senha do admin da máquina Linux"
}

variable "vm_windows_nic_name" {
  type        = string
  description = "Nome da NIC da máquina virtual Windows"
}

variable "vm_windows_name" {
  type        = string
  description = "Nome da VM Windows"
}

variable "vm_windows_size" {
  type        = string
  description = "Tamanho da VM Windows"
}

variable "vm_windows_admin_username" {
  type        = string
  description = "Nome de usuário do admin da VM Windows"
}

variable "vm_windows_admin_password" {
  type        = string
  description = "Senha do admin da VM Windows"
}

variable "pip_linux_name" {
  type        = string
  description = "Nome do Public IP da máquina Linux"
}

variable "pip_windows_name" {
  type        = string
  description = "Nome do Public IP da máquina Windows"
}

variable "nsg_rdp_name" {
  type        = string
  description = "Nome do NSG da arquitetura proposta"
}

variable "rule_allow_rdp_name" {
  type        = string
  description = "Nome da regra que libera o acesso RDP ao ambiente"
}

variable "rule_allow_rdp_priority" {
  type        = number
  description = "Prioridade da regra que permite o acesso RDP ao ambiente"
}

variable "rule_allow_rdp_source_port_range" {
  type        = any
  description = "Range de portas de origem da regra que permite o acesso RDP"
}

variable "rule_allow_rdp_source_address_prefix" {
  type        = string
  description = "Endereço de IP de origem da regra que permite o acesso RDP"
}

variable "nsg_ssh_name" {
  type        = string
  description = "Nome do NSG que liberará a porta SSH"
}

variable "rule_allow_ssh_name" {
  type        = string
  description = "Nome da regra do NSG que libera a porta SSH"
}

variable "rule_allow_ssh_priority" {
  type        = number
  description = "Prioridade da regra que libera o acesso ao SSH"
}

variable "rule_allow_ssh_source_port_range" {
  type        = any
  description = "Range de portas de origem da regra que permite o acesso SSH"
}

variable "rule_allow_ssh_source_address_prefix" {
  type        = string
  description = "Endereço de IP de origem da regra que permite o acesso SSH"
}