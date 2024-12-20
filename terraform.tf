terraform {
  required_version = ">= 1.3.1"
  backend "azurerm" {
    use_azuread_auth = true
    use_oidc         = var.use_oidc ### This is required for GitHub Actions
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.65.0"
    }
  }
}
