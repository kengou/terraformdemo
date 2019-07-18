data "azurerm_resource_group" "test" {
  name = "${var.resource_group}"
}
data "azurerm_subnet" "test" {
  name                 = "${var.subnet}"
  virtual_network_name = "${var.vnet}"
  resource_group_name  = "${var.resource_group}"
}