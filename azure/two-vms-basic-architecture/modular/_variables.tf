variable "rg_name" {
  type        = string
  description = "Nome do Resource Group que conterá todos os recursos"
}

variable "rg_location" {
  type        = string
  description = "Nome da localização onde o Resource Group será criado"
}

variable "admin_password" {
  type        = string
  description = "Senha do administrador das máquinas"
}