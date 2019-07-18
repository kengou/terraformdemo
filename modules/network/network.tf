resource "azurerm_virtual_network" "test" {
  name                = "vnet${var.env}"
  location            = "North Europe"
  resource_group_name = "${var.resource_group}"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "test" {
  name                 = "subnet${var.env}"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefix       = "10.0.1.0/24"
}
