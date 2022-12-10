# Introduction 
AKS deployment with Nginx Ingress controller using Terraform.

# Manual AKS Setup
1. Clone the Repo
2. Login to Azure  
  **<code>az login</code>**  
3. Update the Terraform backend key from Azure and then apply iac using Terraform  
  **<code>terraform init</code>**  
  **<code>terraform apply</code>**  
4. Azure Container registry should be in place (create one)
5. AKS and ACR Integration 
  **<code>az aks update -n <aks-name> -g <aks-rg> --attach-acr <acr-name></code>**  
6. Cluster is now ready to pull images from ACR for app deployment  
7. Go to AKS dashboard on Azure, Services And Ingresses and find the LoadBalancer External IP as the K8s base URL.

#Cleanup
Run Terraform destroy.
