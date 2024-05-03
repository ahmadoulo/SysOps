#!/bin/bash

# Mise à jour des paquets
sudo apt update && sudo apt upgrade -y

# Installation de Docker avec curl
curl -sSL https://get.docker.io | sh

# Ajout de l'utilisateur au groupe Docker
sudo usermod -aG docker $USER

# Redémarrage de la session pour appliquer les changements
newgrp docker
