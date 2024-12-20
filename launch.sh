# #!/bin/bash

# # Construire l'image Docker pour Terraform et Azure CLI
docker build -t terraform-azure-cli Devops/Terraform

# # Initialiser Terraform
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v $(pwd)/Devops/Terraform/.azure:/root/.azure -w /workspace terraform-azure-cli start.sh init

# # Planifier les modifications
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v $(pwd)/Devops/Terraform/.azure:/root/.azure -w /workspace terraform-azure-cli terraform plan

# # Appliquer les modifications
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v $(pwd)/Devops/Terraform/.azure:/root/.azure -w /workspace terraform-azure-cli terraform apply -auto-approve

# # Récupérer les outputs et les enregistrer dans un fichier
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v $(pwd)/Devops/Terraform/.azure:/root/.azure -w /workspace terraform-azure-cli terraform output -json > Devops/Terraform/terraform_output.json

# # Extraire la configuration kubeconfig
./Devops/Terraform/extract_kubeconfig.sh

# # Construire l'image Docker pour le déploiement Kubernetes
docker build -t kubectl-deployer Devops/Kubernetes/

# Déployer les fichiers de déploiement Kubernetes
docker container run -it --rm -v $(pwd)/Devops/Kubernetes:/workspace -v $(pwd)/Devops/Terraform/.azure:/root/.azure -w /workspace kubectl-deployer /usr/local/bin/start.sh

# Vérifier les adresses IP des services
while true; do
  docker container run -it --rm -v $(pwd)/Devops/Kubernetes:/workspace -v $(pwd)/Devops/Terraform/.azure:/root/.azure -w /workspace kubectl-deployer /usr/local/bin/ip.sh
  if [ $? -eq 0 ]; then
    break
  fi
done