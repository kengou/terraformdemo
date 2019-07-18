module "vmss_apache" {
  source = "../modules/vmss"
  resource_group ="${var.resource_group}"
  env = "${var.env}"
  vnet = "vnet${var.env}"
  subnet = "subnet${var.env}"
  custom_data = "${var.custom_data}"
}