locals {
  prefix  = "akstest"
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "${local.prefix}-rg"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.prefix}-aks"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "aksdns"

# Should deploy at least two nodes.
# That way, the workload will have a high availability pattern with two replicas.
# One node deployment as a result of quota in Azure trial account.
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_Ds2_v2"
    enable_auto_scaling = true
    // min_count           = 1
    // max_count           = 10
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_key_vault_access_policy" "aks_access_to_kv" {
  depends_on       = [data.azurerm_kubernetes_cluster.aks]
  key_vault_id     = data.azurerm_key_vault.tf_kv.id
  tenant_id        = data.azurerm_client_config.current.tenant_id
  object_id        = data.azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id

  certificate_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]
}

resource "helm_release" "ingress" {
  depends_on       = [azurerm_key_vault_access_policy.aks_access_to_kv]
  name             = "${local.prefix}-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-ns"
  create_namespace = true
}

resource "helm_release" "akv2k8" {
  depends_on       = [helm_release.ingress]
  name             = "${local.prefix}-akv2k8"
  repository       = "https://charts.spvapi.no"
  chart            = "akv2k8s"
  namespace        = "akv2k8s"
  create_namespace = true
}

resource "kubectl_manifest" "create_namespace" {
  depends_on = [helm_release.akv2k8] 
  yaml_body  = file("../manifests/createNamespace.yaml")
}

resource "kubectl_manifest" "sync_cert_service" {
  depends_on = [kubectl_manifest.create_namespace] 
  yaml_body  = file("../manifests/syncCert.yaml")
}

resource "kubectl_manifest" "use_cert_service" {
  depends_on = [kubectl_manifest.sync_cert_service] 
  yaml_body  = file("../manifests/useCert.yaml")
}