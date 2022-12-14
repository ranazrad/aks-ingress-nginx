data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "tf_kv" {
  name                = azurerm_key_vault.mssre_vault.name
  resource_group_name = azurerm_key_vault.mssre_vault.name
}

data "azurerm_kubernetes_cluster" "aks" {
  depends_on          = [azurerm_kubernetes_cluster.aks]
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_kubernetes_cluster.aks.resource_group_name
}