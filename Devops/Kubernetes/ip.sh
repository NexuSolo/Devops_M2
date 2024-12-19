#!/bin/bash

# Fonction pour vérifier les adresses IP externes des services
check_ips() {
  front_ip=$(kubectl get service front-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  back_ip=$(kubectl get service back-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

  if [[ -z "$front_ip" || -z "$back_ip" ]]; then
    echo "Les adresses IP ne sont pas encore prêtes. Relance du conteneur dans 10 secondes..."
    sleep 10
    exit 1
  else
    echo "Les adresses IP sont prêtes :"
    echo "Front IP: $front_ip"
    echo "Back IP: $back_ip"
  fi
}

# Appeler la fonction pour vérifier les adresses IP
check_ips