resource "azurerm_api_management_api" "swapi" {
  name                = "swapi-api"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name

  display_name = "Star Wars API"
  revision     = "1"

  subscription_required = true
  protocols             = ["https"]
  path                  = "swapi"

  import {
    content_format = "openapi"
    content_value  = file("${path.module}/../apis/swapi.openapi.yaml")
  }
}

resource "azurerm_api_management_product" "demos" {
  product_id            = "demos"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "Demos Product"
  subscription_required = true
  approval_required     = true
  published             = true
}

resource "azurerm_api_management_product_api" "demos_swapi" {
  api_name            = azurerm_api_management_api.swapi.name
  product_id          = azurerm_api_management_product.demos.product_id
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
}

# resource "azurerm_api_management_api_policy" "swapi_api_policy" {
#   api_management_name = azurerm_api_management.apim.name
#   resource_group_name = azurerm_resource_group.rg.name

#   api_name    = azurerm_api_management_api.apim.name
#   xml_content = file("${path.module}/policies/swapi_api_policy.xml")
# }
