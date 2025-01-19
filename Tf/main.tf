

# Resource Group
resource "azurerm_resource_group" "pm" {
  location = var.location
  name     = var.resource_group_name
}

# Network Security Group (NSG) for VM
resource "azurerm_network_security_group" "nsgolasea" {
  name                = "seaola-security-group"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSSHFromBastion"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.1.224.0/19"
    destination_address_prefix = "*"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "olasea" {
  name                = "olasea"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.1.0.0/16"]

  tags = {
    environment = "dev"
  }
}

# Bastion Subnet
resource "azurerm_subnet" "olaseasubnet1" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.olasea.name
  address_prefixes     = ["10.1.128.0/18"]
}

# Public IP for Bastion
resource "azurerm_public_ip" "olaseaip" {
  name                = "publicolasea"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Bastion
resource "azurerm_bastion_host" "olaseabas" {
  name                = "olaseabas2"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.olaseasubnet1.id
    public_ip_address_id = azurerm_public_ip.olaseaip.id
  }
}

# Subnet for VM
resource "azurerm_subnet" "vmolasea2" {
  name                 = "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.olasea.name
  address_prefixes     = ["10.1.192.0/18"]
}

# Network Interface for VM
resource "azurerm_network_interface" "nicseaola1" {
  name                = "nic-olasea"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vmolasea2.id
    private_ip_address_allocation = "Dynamic"
  }
}

# # TLS Private Key for SSH Key
# resource "tls_private_key" "pvtkvy" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# Linux Virtual Machine with Random Password
# resource "random_password" "randpass" {
#   length  = 16
#   special = true
#   upper   = true
#   lower   = true
# }

resource "azurerm_linux_virtual_machine" "linuxseaola" {
  name                = "linuxolaseavm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = var.admin_password
  disable_password_authentication = false

  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = tls_private_key.pvtkvy.public_key_openssh
  # }

  network_interface_ids = [
    azurerm_network_interface.nicseaola1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  provision_vm_agent = true

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# Outputs
output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.nicseaola1.ip_configuration[0].private_ip_address
}

# output "random_password" {
#   description = "Randomly generated password for the VM"
#   value       = random_password.randpass.result
#   sensitive   = true
# }

output "bastion_ip" {
  description = "Public IP address of the Bastion host"
  value       = azurerm_public_ip.olaseaip.ip_address
}
