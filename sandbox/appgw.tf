module "appgw" {
  source = "../modules/appgw"
  resource_group ="${var.resource_group}"
  env = "${var.env}"
  vnet = "vnet${var.env}"
  subnet = "subnet${var.env}"
  subnet_appgw = "subnet${var.env}forntend"
}