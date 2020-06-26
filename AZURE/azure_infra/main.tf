#Create Resource group 
resource "azurerm_resource_group" "vnet_rsg" {
  name     = var.name["vnet_rsg"]
  location = var.location
}
# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name = "vnet"
  resource_group_name = var.vnet_rsg
  location = var.location
  address_space = var.vnet_cidr
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name = var.name["subnet"]
  address_prefix = var.subnet_cidr
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = var.vnet_rsg
}
# Network Security Group & Rule
resource "azurerm_network_security_group" "nsg" {
    name                = var.name["nsg"]
    location            = var.location
    resource_group_name = var.vnet_rsg

    security_rule {
        name                       = "AllowHTTPS"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule {
        name                       = "AllowHTTPS"
        priority                   = 100
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
resource "azurerm_public_ip" "public_ip" {
  name                         = var.name["public_ip"]
  location                     = var.location
  resource_group_name          = var.vnet_rsg
  public_ip_address_allocation = "static"
}
# Network Interface
resource "azurerm_network_interface" "network_interface" {
  name                = var.name["network_interface"]
  location            = var.location
  resource_group_name = var.vnet_rsg

  ip_configuration {
    name                          = "nic"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
  }
}
# Virtual Machine
resource "azurerm_virtual_machine" "virtual_machine" {
  name                = var.name["vm_name"]
  vm_size             = var.vm_size
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name
  network_interface_ids = azurerm_network_interface.network_interface.id

  storage_image_reference {
    publisher = var.storage_image_reference["publisher"]
    offer     = var.storage_image_reference["offer"]
    sku       = var.storage_image_reference["sku"]
    version   = var.storage_image_reference["version"]
  }

  storage_os_disk {
    name              = var.vm_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.user
    admin_password = var.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
