variable "rg_name" {
  type        = string
  description = "Nome do Resource Group que conterá todos os recursos"
}

variable "rg_location" {
  type        = string
  description = "Nome da localização onde o Resource Group será criado"
}

variable "vms_windows" {
  type        = map(map(any))
  description = "Máquinas virtuais Windows a serem criadas"
}

variable "vms_linux" {
  type        = map(map(any))
  description = "Máquinas virtuais Linux a serem criadas"
}