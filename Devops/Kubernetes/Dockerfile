FROM ubuntu:latest

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    software-properties-common \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Installer Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Installer kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Copier les fichiers de déploiement et les scripts dans le conteneur
COPY . /workspace
COPY start.sh /usr/local/bin/start.sh
COPY ip.sh /usr/local/bin/ip.sh

WORKDIR /workspace

# Rendre les scripts exécutables
RUN chmod +x /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/ip.sh