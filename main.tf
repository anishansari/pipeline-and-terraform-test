provider "azurerm" {
    version = "2.5.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "anishRG"
        storage_account_name = "terraformstfl"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}



resource "azurerm_resource_group" "anish_terraform_test" {
  name = "ans-tes-grp"
  location = "Australia East"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "node-taste-anish"
  location                  = azurerm_resource_group.anish_terraform_test.location
  resource_group_name       = azurerm_resource_group.anish_terraform_test.name

  ip_address_type     = "public"
  dns_name_label      = "binarythistlewa"
  os_type             = "Linux"

  container {
      name            = "node-tes-anish"
      image           = "anish78/nodetest:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}