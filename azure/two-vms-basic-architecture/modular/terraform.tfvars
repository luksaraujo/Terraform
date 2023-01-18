rg_name        = "lab-lucas-souza-tf-simple-infra-rg01"
rg_location    = "eastus"
vms_windows = {
  "vm-windows-01" = { size = "Standard_B1ms", admin_username = "lukita", admin_password = "P@assw0rd", public_ip = true }
}
vms_linux = {
  "vm-linux-01" = { size = "Standard_B1ms", admin_username = "lukita", admin_password = "P@assw0rd", public_ip = true }
}