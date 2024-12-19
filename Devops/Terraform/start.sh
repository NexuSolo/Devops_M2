#!/bin/bash

# Se connecter à Azure de manière interactive
az login

# Exécuter la commande Terraform passée en argument
terraform "$@"