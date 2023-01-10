variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group que será importado"
}

variable "vnet_name" {
  type        = string
  description = "Nome da VNet onde a VM será implementada"
}

variable "estrategia_de_implementacao" {
  type        = string
  description = "Variável que armazena a estratégia de implementação das VMs. Aceita os valores 'sequencial' e 'personalizado'."
}

variable "sequencial_qtde_vms" {
  type        = number
  description = "Armazena a quantidade de máquinas virtuais a serem implementadas caso a abordagem escolhida seja 'sequencial'"
  default     = 0
}

variable "sequencial_identical_vm_names" {
  type        = string
  description = "Nome das máquinas virtuais a serem implementadas de forma sequencial. O nome final será '[var.sequencial_identical_vm_names]-[index]'. Exemplo: vm-teste-01, vm-teste-02, etc."
}

variable "nic_ip_configuration_name" {
  type        = string
  default     = "internal"
  description = "Nome usado pela IP Configuration da NIC da(s) VM(s)"
}

variable "nic_private_ip_address_version" {
  type        = string
  default     = "IPv4"
  description = "Versão de IP a ser usado no deployment das NICs. Aceita 'IPv4' e 'IPv6'"
}

variable "nic_private_ip_address_allocation" {
  type        = string
  default     = "Dynamic"
  description = "O método de alocação usado para o endereço IP privado. Os valores possíveis são 'Dynamic' e 'Static'."
}

variable "nic_private_ip_address" {
  type        = string
  default     = null
  description = "Endereço de IP privado estático a ser usado na NIC. Deve ser usado apenas quando o método de alocação do IP privado for 'Static'"
}

variable "os_vms" {
  type        = string
  description = "Sistema operacional que será instalado na(s) VM(s). Aceita: 'Windows' e 'Linux'."
}

variable "vm_size" {
  type        = string
  description = "Tamanho da(s) VM(s) que será(ão) criada(s)"
}

variable "admin_username" {
  type        = string
  description = "Nome de usuário do adminsitrador das máquinas"
}

variable "os_disk_source_image_reference" {
  type        = any
  description = "Informações sobre a imagem do sistema operacional da VM"
}

variable "os_disk" {
  type        = any
  description = "Informações do OS Disk da VM"
}

variable "disable_password_authentication" {
  type        = bool
  description = "Parâmetro que define se a máquina Linux usará senha de admin ou SSH."
  default     = false
}

variable "admin_password" {
  type        = string
  description = "Senha do administrador da máquina virtual"
  default     = null
}

variable "ssh_public_key" {
  type        = string
  default     = null
  description = "A chave pública que deve ser usada para autenticação, que precisa ser de pelo menos 2048 bits e no formato ssh-rsa"
}

variable "subnet_name" {
  type        = string
  description = "Nome da Subnet onde as VMs serão criadas."
}