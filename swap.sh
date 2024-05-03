#!/bin/bash

# Création d'un fichier swap de 8 Go
sudo fallocate -l 8G /swapfile

# Attribution des permissions appropriées au fichier swap
sudo chmod 600 /swapfile

# Configuration du fichier swap
sudo mkswap /swapfile

# Activation du fichier swap
sudo swapon /swapfile

# Affichage des informations sur le fichier swap activé
sudo swapon --show

# Ajout du fichier swap au fichier /etc/fstab pour qu'il persiste après le redémarrage
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Configuration du swappiness
sudo sysctl vm.swappiness=10

# Appliquer la configuration du swappiness
sudo sysctl -p

# Affichage de l'utilisation de l'espace disque
df -h
