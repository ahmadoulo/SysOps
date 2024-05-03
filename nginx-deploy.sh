#!/bin/bash

# Mise à jour des paquets
sudo apt update && sudo apt upgrade -y

# Installation de Nginx
sudo apt install nginx -y

# Démarrage du service Nginx
sudo systemctl start nginx

# Activation du démarrage automatique de Nginx
sudo systemctl enable nginx

# Affichage du statut de Nginx
sudo systemctl status nginx
