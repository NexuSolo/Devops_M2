#!/bin/bash

# Configurer kubectl avec le fichier kubeconfig
export KUBECONFIG=/workspace/kubeconfig.yaml

# Appliquer les fichiers de déploiement Kubernetes
kubectl apply -f deployment-front.yaml
kubectl apply -f deployment-back.yaml
kubectl apply -f deployment-bdd.yaml