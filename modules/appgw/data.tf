data "azurerm_resource_group" "main" {
  name = "${var.resource_group}"
}
data "azurerm_subnet" "subnetappgw" {
  name                 = "${var.subnet_appgw}"
  virtual_network_name = "${var.vnet}"
  resource_group_name  = "${var.resource_group}"
}



