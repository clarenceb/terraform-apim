resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}

resource "random_string" "azurerm_api_management_name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_api_management" "apim" {
  name                = "example-apim-${random_string.azurerm_api_management_name.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_email     = var.publisher_email
  publisher_name      = var.publisher_name
  sku_name            = "${var.sku}_${var.sku_count}"
}

resource "azurerm_api_management_policy" "base_apim_policy" {
  api_management_id = azurerm_api_management.apim.id
  xml_content       = templatefile("${path.module}/policies/base_apim_policy.xml.tftpl", {
    cidrs = local.prod_cidrs
  })
}

# resource "azurerm_api_management_policy" "base_apim_policy" {
#   api_management_id = azurerm_api_management.apim.id
#   xml_content       = file("${path.module}/../jinja/base_apim_policy.xml", {
# }
