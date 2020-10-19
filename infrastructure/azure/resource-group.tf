resource "azurerm_resource_group" "main" {
  location = "centralus"
  name     = "rg-${local.project}"
  tags     = local.tags
}
