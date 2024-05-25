#!/bin/bash

# Mettre à jour le système
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Installer Docker
echo "Installing Docker..."
sudo apt install docker.io -y

# Installer Docker Compose
echo "Installing Docker Compose..."
sudo apt install docker-compose -y

# Démarrer et activer Docker
echo "Starting and enabling Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Créer un répertoire pour GLPI
echo "Creating directory for GLPI..."
mkdir -p ~/glpi-docker
cd ~/glpi-docker

# Créer le fichier docker-compose.yml
echo "Creating docker-compose.yml..."
cat <<EOL > docker-compose.yml
version: '3.3'

services:
  glpi:
    image: diouxx/glpi:latest
    container_name: glpi
    ports:
      - "80:80"
    environment:
      - MYSQL_ROOT_PASSWORD=rootpassword
      - MYSQL_USER=glpi
      - MYSQL_PASSWORD=glpipassword
      - MYSQL_DATABASE=glpidb
    volumes:
      - glpi-data:/var/www/html
    depends_on:
      - db

  db:
    image: mysql:5.7
    container_name: glpi-db
    environment:
      - MYSQL_ROOT_PASSWORD=rootpassword
      - MYSQL_USER=glpi
      - MYSQL_PASSWORD=glpipassword
      - MYSQL_DATABASE=glpidb
    volumes:
      - db-data:/var/lib/mysql

volumes:
  glpi-data:
  db-data:
EOL

# Lancer Docker Compose
echo "Starting Docker Compose..."
sudo docker-compose up -d

# Vérifier l'état des conteneurs
echo "Checking the status of containers..."
sudo docker ps

echo "GLPI deployment completed. Access GLPI at http://your_server_ip"
