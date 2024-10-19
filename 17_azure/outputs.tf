output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "azure_vm_name" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.name
}

output "azure_vm_location" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.location
}

output "vm_size" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.size
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}

output "azure_os_disk_name" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.os_disk
}

output "tls_public_key" {
  value = tls_private_key.ssh_keypair.public_key_openssh
}