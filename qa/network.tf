module "network" {
  source = "../modules/network"
  env = "${var.env}"
  resource_group = "${var.resource_group}"
}
