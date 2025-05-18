#!/bin/bash

# Mise à jour des paquets
sudo apt update && sudo apt upgrade -y

# Installation de Docker avec curl
curl -sSL https://get.docker.io | sh

# Ajout de l'utilisateur au groupe Docker
sudo usermod -aG docker $USER

# Redémarrage de la session pour appliquer les changements
newgrp docker


sudo docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=root123* -d -p 3306:3306 mysql:latest --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

echo "mysql user = root / mysql password = root123*"
echo "Pour accéder à la base donnée : docker exec -it mysql-db /bin/bash"
