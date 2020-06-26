variable "location" {
  type    = list(string)
}

variable "vnet_cidr" {
  description = "CIDR block for Virtual Network"
}
variable "subnet_id" {
}
variable "subnet_cidr" {
  description = "CIDR block for Subnet within a Virtual Network"
}
variable "vm_size" {
}
variable "storage_image_reference" {
    type = map(any)
    default = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "7.3"
      version   = "latest"
  }
}
variable "name" {
  type = map(any)
  default = {
    vnet_rsg            = "vnet_rsg"
    subnet              = "subnet"
    nsg                 = "nsg"
    network_interface   = "network_interface"
    vm_name             = "vm_name"

  }
}
variable "user" {
}
variable "password"{
}