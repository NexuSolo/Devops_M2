FROM ubuntu:latest

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    software-properties-common \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Installer Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && apt-get install -y terraform

# Installer Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Copier les fichiers Terraform et le script de démarrage dans le conteneur
COPY . /workspace
COPY start.sh /usr/local/bin/start.sh

WORKDIR /workspace

# Rendre le script de démarrage exécutable
RUN chmod +x /usr/local/bin/start.sh

# Entrée par défaut du conteneur
CMD ["sh"]