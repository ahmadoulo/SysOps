#!/bin/bash

# Mise à jour des packages
sudo apt update

# Installation de Docker si ce n'est pas déjà fait
if ! command -v docker &> /dev/null
then
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# Installation de Jenkins si ce n'est pas déjà fait
if ! command -v jenkins &> /dev/null
then
    sudo apt install -y openjdk-11-jdk
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt install -y jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
fi

# Installation d'Ansible si ce n'est pas déjà fait
if ! command -v ansible &> /dev/null
then
    sudo apt install -y ansible
fi

# Installation de Nginx si ce n'est pas déjà fait
if ! command -v nginx &> /dev/null
then
    sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
fi
