resource "azurerm_resource_group" "resource_group" {
  name     = "${var.seg1}-${var.seg2}-${var.seg3}--${var.var.location}"
  location = "${var.location}"
  rsg_count = "${var.rsg_count}"
  lifecycle {
    prevent_destroy = "true"
  }

}
