# Projet DevOps avec Angular, Express et PostgreSQL

Ce projet est une application web composée de trois parties principales : une base de données PostgreSQL, un frontend Angular et un backend Express. La gestion de l'infrastructure et du déploiement est automatisée avec Docker, Kubernetes et Terraform.

## Table des matières

1. [Structure du projet](#structure-du-projet)
2. [Prérequis](#prérequis)
3. [Lancement en développement](#lancement-en-développement)
4. [Lancement en production locale](#lancement-en-production-locale)
5. [Pipeline DevOps](#pipeline-devops)
6. [Script de lancement (`launch.sh`)](#script-de-lancement-launchsh)
7. [Script de nettoyage (`clear.sh`)](#script-de-nettoyage-clearsh)

---

## Structure du projet

- **Base de données (BDD)** : Utilise PostgreSQL pour stocker les données.
- **Frontend (Front)** : Développé avec Angular pour l'interface utilisateur.
- **Backend (Back)** : Développé avec Express pour gérer les requêtes et la logique métier.

---

## Prérequis

- **Docker**
- **Linux obligatoire**
- **Fichier de configuration Terraform** : Créez un fichier `Devops/Terraform/terraform.tfvars` avec les informations suivantes (pour le déploiement sur Azure uniquement) :

```hcl
subscription_id = "votre_subscription_id"
tenant_id       = "votre_tenant_id"
```

---

## Lancement en développement

Pour lancer l'application en mode développement, utilisez le fichier `docker-compose.dev.yml` :

```bash
docker-compose -f docker-compose.dev.yml up -d --build
```

---

## Lancement en production locale

Pour lancer l'application en mode production, utilisez le fichier `docker-compose.prod.yml` :

```bash
docker-compose -f docker-compose.prod.yml up -d --build
```

---

## Pipeline DevOps

La gestion DevOps de ce projet repose sur trois technologies principales :

1. **Docker** : Containerise les applications frontend, backend et la base de données.
2. **Kubernetes** : Orchestrateur pour déployer et gérer les conteneurs sur un cluster AKS (Azure Kubernetes Service).
3. **Terraform** : Automatisation de la création et de la gestion de l'infrastructure sur Azure.

---

## Script de lancement (`launch.sh`)

Le script `launch.sh` est un outil automatisé pour provisionner l'infrastructure sur Azure et déployer les applications dans un cluster Kubernetes. Voici les étapes principales qu'il réalise :

### 1. Connexion à Azure

Lors de l'exécution, un code s'affichera dans le terminal. Suivez les instructions fournies pour vous connecter à votre compte Azure et sélectionner un abonnement.

### 2. Provisionnement de l'infrastructure avec Terraform

- **Construction de l'image Docker pour Terraform et Azure CLI** : Une image Docker contenant Terraform et l'Azure CLI est créée.
- **Initialisation de Terraform** : Initialise Terraform dans le répertoire de travail.
- **Planification des modifications** : Génère un plan des modifications à appliquer.
- **Application des modifications** : Déploie l'infrastructure sur Azure en fonction du plan.
- **Récupération des outputs** : Enregistre les outputs de Terraform dans un fichier JSON.

### 3. Déploiement dans Kubernetes

- **Extraction de la configuration kubeconfig** : Récupère la configuration kubeconfig pour permettre à Kubernetes de se connecter au cluster AKS.
- **Construction de l'image Docker pour Kubernetes** : Une image Docker contenant kubectl est créée.
- **Déploiement des fichiers Kubernetes** : Utilise kubectl pour déployer les fichiers de configuration (pods, services, etc.).
- **Vérification des adresses IP des services** : Vérifie les adresses IP des services déployés jusqu'à ce qu'ils soient disponibles.

### Utilisation

Exécutez le script `launc.sh` créer les ressources Azure grace a Terraform et lancer les pods de Kubernetes:

```sh
./launch.sh
```

---

## Script de nettoyage (`clear.sh`)

Le script `clear.sh` est utilisé pour détruire l'infrastructure provisionnée sur Azure à l'aide de Terraform. Voici son contenu :

### Utilisation

Exécutez le script `clear.sh` pour supprimer les ressources Azure créées par Terraform :

```sh
./clear.sh
```