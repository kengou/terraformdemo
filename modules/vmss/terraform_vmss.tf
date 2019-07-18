resource "azurerm_public_ip" "test" {
  name                = "test"
  location            = "${data.azurerm_resource_group.test.location}"
  resource_group_name = "${var.resource_group}"
  allocation_method   = "Static"
}

resource "azurerm_virtual_machine_scale_set" "example" {
  name                = "${var.env}-vmss"
  location            = "${data.azurerm_resource_group.test.location}"
  resource_group_name = "${var.resource_group}"
  upgrade_policy_mode = "Manual"

  sku {
    name     = "Standard_D1_v2"
    tier     = "Standard"
    capacity = 1
  }

  os_profile {
    computer_name_prefix = "${var.env}-apache"
    admin_username       = "ubuntu"
    custom_data        = "${var.custom_data}"
  }
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/id_rsa.pub")}"
    }
  }

  network_profile {
    name    = "web_ss_net_profile"
    primary = true

    ip_configuration {
      name      = "internal"
      subnet_id = "${data.azurerm_subnet.test.id}"
      primary   = true
    }
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
