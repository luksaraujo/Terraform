variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group que será importado"
}

variable "vnets" {
  type        = any
  description = "Virtual Networks que serão criadas, juntamente com suas subnets"
}