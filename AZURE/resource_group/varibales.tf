variable "seg1" {
  type = string
  default = "my"
}
variable "seg2" {
  type = string
  default = "test"
}
variable "seg3" {
  type = string
	default = "candidate"
}
variable "rsg_count" {
  type = number
}
variable "location" {
  type    = list(string)
}

locals {
  base_tags = {
    Location    = "${var.location}"
    ObjectName  = "${var.seg1}-${var.seg2}-${var.seg3}--${var.var.location}"
    
  }
}