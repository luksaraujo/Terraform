variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group que será importado"
}

variable "vnet_name" {
  type        = string
  description = "Nome da VNet que será criada"
}

variable "vnet_address_space" {
  type        = string
  description = "Address Space da VNet"
}

variable "dns_servers" {
  type        = any
  description = "DNS Servers da VNet"
  default     = null
}

variable "subnets" {
  type        = any
  description = "Subnets da VNet"
}