resource "azurerm_key_vault" "secret_provider" {
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  location                        = azurerm_resource_group.main.location
  name                            = "kv-${local.project}"
  resource_group_name             = azurerm_resource_group.main.name
  sku_name                        = "standard"
  soft_delete_enabled             = true
  soft_delete_retention_days      = 30
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  tags                            = local.tags

  # contact {
  #   email = "joe@olive-steel.com"
  #   name  = "Joe Secrets"
  #   phone = "(555) 555-5555"
  # }
}

resource "azurerm_key_vault_secret" "storage_connection_string_primary" {
  name         = "storage-connection-string-primary"
  value        = azurerm_storage_account.diagnostics.primary_connection_string
  key_vault_id = azurerm_key_vault.secret_provider.id
  tags         = local.tags
}

resource "azurerm_key_vault_secret" "storage_connection_string_secondary" {
  name         = "storage-connection-string-secondary"
  value        = azurerm_storage_account.diagnostics.secondary_connection_string
  key_vault_id = azurerm_key_vault.secret_provider.id
  tags         = local.tags
}

resource "azurerm_key_vault_certificate" "ingress_tls_pem" {
  key_vault_id = azurerm_key_vault.secret_provider.id
  name         = "ingress-tls"

  certificate {
    contents = filebase64("./certificates/ingress-tls.pem")
    password = ""
  }

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = false
    }

    secret_properties {
      content_type = "application/x-pem-file"
    }
  }

  tags = local.tags
}

resource "azurerm_key_vault_secret" "mit_license" {
  name         = "mit-license-base64"
  value        = file("./certificates/LICENSE.b64")
  key_vault_id = azurerm_key_vault.secret_provider.id
  tags         = local.tags
}

resource "azurerm_key_vault_secret" "mit_license_nl" {
  name         = "mit-license-base64-nl"
  value        = file("./certificates/LICENSE-nl.b64")
  key_vault_id = azurerm_key_vault.secret_provider.id
  tags         = local.tags
}

resource "azurerm_key_vault_secret" "mit_license_ic" {
  name         = "mit-license-base64-ic"
  value        = file("./certificates/LICENSE-ic.b64")
  key_vault_id = azurerm_key_vault.secret_provider.id
  tags         = local.tags
}