locals {
  full_resource_group_name = "${var.resource_group_name_prefix}-${var.resource_group_name}"
}

resource "tls_private_key" "ssh_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = local.full_resource_group_name
}

resource "azurerm_virtual_network" "my_terraform_network" {
  name                = var.azurerm_virtual_network_name
  address_space       = var.vnet_range
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = var.subnet_range
}

resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = var.azurerm_public_ip
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "my_terraform_nic" {
  name                = "myNIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet.id
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id
  depends_on                = [azurerm_virtual_network.my_terraform_network]
}

resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = "${var.azurerm_virtual_network_name}-sg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.allowed_ports
    content {
      name                       = "allow-port-${security_rule.value}"
      priority                   = 100 + security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  security_rule {
    name                       = "egress-allow-all"
    priority                   = 900
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name                  = "webserver"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  size                  = var.azurerm_vm_size

  computer_name  = var.computer_name
  admin_username = var.user_name

  custom_data = base64encode(file("${path.module}/entry_script.sh"))

  admin_ssh_key {
    username   = var.user_name
    public_key = tls_private_key.ssh_keypair.public_key_openssh
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  os_disk {
    disk_size_gb         = 30
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
}