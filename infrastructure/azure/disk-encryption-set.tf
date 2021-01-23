resource "azurerm_disk_encryption_set" "des" {
  name                = "des-${local.project}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  key_vault_key_id    = azurerm_key_vault_key.des.id
  tags                = local.tags


  identity {
    type = "SystemAssigned"
  }
}

