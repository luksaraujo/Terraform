## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm-linux-dinamico](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.vm-linux-sequencial](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nic-dinamico](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.nic-sequencial](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_windows_virtual_machine.vm-windows-dinamico](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [azurerm_windows_virtual_machine.vm-windows-sequencial](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Senha do administrador da máquina virtual. Sempre requerido, uma vez que o módulo não suporta SSH KEYS para Linux | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Nome de usuário do adminsitrador das máquinas | `string` | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Parâmetro que define se a máquina Linux usará senha de admin ou SSH. | `bool` | `false` | no |
| <a name="input_estrategia_de_implementacao"></a> [estrategia\_de\_implementacao](#input\_estrategia\_de\_implementacao) | Variável que armazena a estratégia de implementação das VMs. Aceita os valores 'sequencial' e 'dinamico'. | `string` | n/a | yes |
| <a name="input_nic_ip_configuration_name"></a> [nic\_ip\_configuration\_name](#input\_nic\_ip\_configuration\_name) | Nome usado pela IP Configuration da NIC da(s) VM(s) | `string` | `"internal"` | no |
| <a name="input_nic_private_ip_address"></a> [nic\_private\_ip\_address](#input\_nic\_private\_ip\_address) | Endereço de IP privado estático a ser usado na NIC. Deve ser usado apenas quando o método de alocação do IP privado for 'Static' | `string` | `null` | no |
| <a name="input_nic_private_ip_address_allocation"></a> [nic\_private\_ip\_address\_allocation](#input\_nic\_private\_ip\_address\_allocation) | O método de alocação usado para o endereço IP privado. Os valores possíveis são 'Dynamic' e 'Static'. | `string` | `"Dynamic"` | no |
| <a name="input_nic_private_ip_address_version"></a> [nic\_private\_ip\_address\_version](#input\_nic\_private\_ip\_address\_version) | Versão de IP a ser usado no deployment das NICs. Aceita 'IPv4' e 'IPv6' | `string` | `"IPv4"` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | Informações do OS Disk da VM | `any` | `null` | no |
| <a name="input_os_disk_source_image_reference"></a> [os\_disk\_source\_image\_reference](#input\_os\_disk\_source\_image\_reference) | Informações sobre a imagem do sistema operacional da VM | `any` | `null` | no |
| <a name="input_os_vms"></a> [os\_vms](#input\_os\_vms) | Sistema operacional que será instalado na(s) VM(s). Aceita: 'Windows' e 'Linux'. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group que será importado | `string` | n/a | yes |
| <a name="input_sequencial_identical_vm_names"></a> [sequencial\_identical\_vm\_names](#input\_sequencial\_identical\_vm\_names) | Nome das máquinas virtuais a serem implementadas de forma sequencial. O nome final será '[var.sequencial\_identical\_vm\_names]-[index]'. Exemplo: vm-teste-01, vm-teste-02, etc. | `string` | `null` | no |
| <a name="input_sequencial_qtde_vms"></a> [sequencial\_qtde\_vms](#input\_sequencial\_qtde\_vms) | Armazena a quantidade de máquinas virtuais a serem implementadas caso a abordagem escolhida seja 'sequencial' | `number` | `0` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | A chave pública que deve ser usada para autenticação, que precisa ser de pelo menos 2048 bits e no formato ssh-rsa | `string` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Nome da Subnet onde as VMs serão criadas. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Tamanho da(s) VM(s) que será(ão) criada(s) | `string` | `null` | no |
| <a name="input_vms_dynamic"></a> [vms\_dynamic](#input\_vms\_dynamic) | Mapa com os valores correspondentes às VMs que serão implementadas na estratégia de implementação dinâmica | `map(map(string))` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Nome da VNet onde a VM será implementada | `string` | n/a | yes |

## Outputs

No outputs.
