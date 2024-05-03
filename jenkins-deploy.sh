#!/bin/bash

# Téléchargement et ajout de la clé GPG de Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg

# Ajout du dépôt Jenkins
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Mise à jour des paquets
sudo apt update -y

# Installation de Jenkins
sudo apt install jenkins -y

# Démarrage du service Jenkins
sudo systemctl start jenkins.service

# Affichage du statut de Jenkins
sudo systemctl status jenkins

# Affichage du mot de passe initial de Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
