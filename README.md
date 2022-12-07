# Introduction 
AKS deployment with Nginx Ingress controller using Terraform.

# Getting Started

1. Clone the Repo
2. Login to Azure  
  **<code>az login</code>**  
3. Apply iac using Terraform  
  **<code>terraform init</code>**  
  **<code>terraform apply</code>**  
4. Azure Container registry should be in place (create one)
5. AKS and ACR Integration 
  **<code>az aks update -n <aks-name> -g <aks-rg> --attach-acr <acr-name></code>**  
6. Cluster is now ready to pull images from ACR for app deployment  
7. Go to Azure pipelines and trigger both webapp-blue and webapp-green as a CI build process
8. Go to Azre Releases and create new release for each webapp, blue and green.
9. Both were deployed on AKS
10. Go to AKS dashboard on Azure, services and find the load-balancer external ip.
11. navigate to <lb-external-ip>/blue to view the blue webapp web-page.
12. navigate to <lb-external-ip>/green to view the green webapp web-page.
