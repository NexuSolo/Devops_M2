Docker front:
    -build dev:
        - docker build -f App/front/Dockerfile.dev -t angular-dev App/front
    -run dev:
        - docker run -it --rm -p 4200:4200 -v $(pwd)/App/front:/app angular-dev
    -build prod:
        - docker build -f App/front/Dockerfile.prod -t angular App/front
    -run prod:
        - docker run -d -p 80:80 angular

Docker back:
    -build dev:
        -docker build -f App/back/Dockerfile.dev -t node-back-dev App/back
    -run dev:
        -docker run -it --rm -p 3000:3000 -v $(pwd)/App/back:/app node-back-dev

    -build prod:
        -docker build -f App/back/Dockerfile.prod -t node-back App/back
    -run prod:
        -docker run -d -p 3000:3000 node-back

Docker bdd:
    -build:
        -docker build --no-cache -t postgres-bdd App/bdd
    -run:
        -docker run --name bdd -p 5432:5432 -v $(pwd)/App/bdd/data:/var/lib/postgresql/data bdd

Lancement dev:
    docker compose -f docker-compose.dev.yml up -d --build

Lancement prod:
    docker compose -f docker-compose.prod.yml up -d --build


<!-- docker build -t nexusolo/devopsm2-front:latest -f App/front/Dockerfile.prod App/front
docker build -t nexusolo/devopsm2-back:latest -f App/back/Dockerfile.prod App/back
docker push nexusolo/devopsm2-front:latest
docker push nexusolo/devopsm2-back:latest -->


<!-- # Connectez-vous à Azure
az login

# Créez un groupe de ressources
az group create --name myResourceGroup --location eastus

# Créez un cluster AKS
az aks create --resource-group myResourceGroup --name myAKSCluster --node-count 2 --enable-addons monitoring --generate-ssh-keys

# Obtenez les informations d'identification du cluster
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

kubectl apply -f Devops/Kubernetes/deployment-front.yaml
kubectl apply -f Devops/Kubernetes/deployment-back.yaml
kubectl apply -f Devops/Kubernetes/deployment-bdd.yaml -->


docker build -t terraform-azure-cli Devops/Terraform
# Initialiser Terraform
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v $(pwd)/Devops/Terraform/.azure:/root/.azure -w /workspace terraform-azure-cli start.sh init

# Planifier les modifications
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v ~/.azure:/root/.azure -w /workspace terraform-azure-cli terraform plan

# Appliquer les modifications
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v ~/.azure:/root/.azure -w /workspace terraform-azure-cli terraform apply -auto-approve

# Récupérer les outputs et les enregistrer dans un fichier
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v ~/.azure:/root/.azure -w /workspace terraform-azure-cli terraform output -json > Devops/Terraform/terraform_output.json

./Devops/Terraform/extract_kubeconfig.sh

docker build -t kubectl-deployer Devops/Kubernetes/

docker container run -it --rm -v $(pwd)/Devops/Kubernetes:/workspace -v $(pwd)/Devops/Terraform/.azure:/root/.azure -w /workspace kubectl-deployer

# Détruire les ressources
docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v ~/.azure:/root/.azure -w /workspace terraform-azure-cli terraform destroy -auto-approve