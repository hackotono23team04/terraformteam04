# Create a resource group
resource "azurerm_resource_group" "sample" {
        name = var.name
        location = var.location
}