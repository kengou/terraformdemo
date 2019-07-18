module "network" {
  source = "../modules/network"
  resource_group ="${var.resource_group}"
  env = "${var.env}"
}