variable "pip_name" {
  type        = string
  description = "Nome do Public IP que será criado."
}

variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group que conterá o Public IP"
}

variable "pip_allocation_method" {
  type        = string
  description = "Tipo de método de alocação do Public IP. Aceita 'Static' ou 'Dynamic' apenas."
}