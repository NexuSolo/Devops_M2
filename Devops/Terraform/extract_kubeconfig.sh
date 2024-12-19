#!/bin/bash

# Extraire la configuration kubeconfig du fichier terraform_output.json
jq -r '.kube_config.value' Devops/Terraform/terraform_output.json > Devops/Kubernetes/kubeconfig.yaml
