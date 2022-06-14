provider "azurerm" {
    #version ="3.9.0"
    features {
      
    }
}

terraform {
  backend "azurerm"{
    resource_group_name = "tf_rg_blobstorage"
    storage_account_name = "pranilocaltfstorage"
    container_name ="tfstatecontainer"
    key = "terraform.tfstate"
  }
}

variable "tfimagevers" {
  type = string
  description = "Latest Image Build"
}
resource "azurerm_resource_group" "tf_rgroup" {
  name = "rg-learn-devops"
  location = "Central India"
}

resource "azurerm_container_group" "tfcg_test" {
  name              = "cgweatherapi"
  location = azurerm_resource_group.tf_rgroup.location
  resource_group_name = azurerm_resource_group.tf_rgroup.name

  ip_address_type = "Public"
  dns_name_label = "pranilocaldns"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "pranilocal/weatherapi:${var.tfimagevers}"
    cpu = "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }
  }

}