# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.42.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.provider_credentials.subscription_id
  tenant_id       = var.provider_credentials.tenant_id
  client_id       = var.provider_credentials.sp_client_id
  client_secret   = var.provider_credentials.sp_client_secret
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "develop-rg"        # ストレージアカウントが所属するリソースグループ
    storage_account_name = "develop01"         # ストレージアカウント名
    container_name       = "tfstate20250911"   # コンテナ名
    key                  = "terraform.tfstate" # ファイル名
  }
}
