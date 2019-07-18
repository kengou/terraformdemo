

resource "azurerm_public_ip" "test" {
  name                = "example-pip"
  resource_group_name = "${var.resource_group}"
  location            = "${data.azurerm_resource_group.main.location}"
  allocation_method   = "Dynamic"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${var.env}-beap"
  frontend_port_name             = "${var.env}-feport"
  frontend_ip_configuration_name = "${var.env}-feip"
  http_setting_name              = "${var.env}-be-htst"
  listener_name                  = "${var.env}-httplstn"
  request_routing_rule_name      = "${var.env}-rqrt"
  redirect_configuration_name    = "${var.env}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = "appgateway"
  resource_group_name = "${var.resource_group}"
  location            = "${data.azurerm_resource_group.main.location}"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = "${data.azurerm_subnet.subnetappgw.id}"
  }

  frontend_port {
    name = "${local.frontend_port_name}"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${local.frontend_ip_configuration_name}"
    public_ip_address_id = "${azurerm_public_ip.test.id}"
  }

  backend_address_pool {
    name = "${local.backend_address_pool_name}"
  }

  backend_http_settings {
    name                  = "${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = "${local.listener_name}"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}"
    frontend_port_name             = "${local.frontend_port_name}"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${local.request_routing_rule_name}"
    rule_type                  = "Basic"
    http_listener_name         = "${local.listener_name}"
    backend_address_pool_name  = "${local.backend_address_pool_name}"
    backend_http_settings_name = "${local.http_setting_name}"
  }
}