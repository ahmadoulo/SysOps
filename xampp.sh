#!/bin/bash

# Mise à jour des paquets
sudo apt update && sudo apt upgrade -y

# Création du répertoire Download
mkdir -p /home/ubuntu/Download

# Téléchargement de XAMPP
cd /home/ubuntu/Download/
wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.12/xampp-linux-x64-8.2.12-0-installer.run

# Attribution des droits d'exécution
chmod +x xampp-linux-x64-8.2.12-0-installer.run

# Installation de XAMPP
sudo ./xampp-linux-x64-8.2.12-0-installer.run

# Démarrage de XAMPP
sudo /opt/lampp/lampp start
