#!/bin/bash

# Default values
SSH_ENABLE=false
SSH_PORT=51001         # Port SSH par défaut modifié
SSH_ALLOW_FROM=""      # Vide = autorisation globale
RESET=false

# Args parsing
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --ssh-enable)
      SSH_ENABLE=true
      ;;
    --ssh-port)
      SSH_PORT="$2"
      shift
      ;;
    --ssh-allow-from)
      SSH_ALLOW_FROM="$2"
      shift
      ;;
    --reset)
      RESET=true
      ;;
    *)
      echo "Option inconnue : $1"
      echo "Usage : $0 [--ssh-enable] [--ssh-port <port>] [--ssh-allow-from <ip>] [--reset]"
      exit 1
      ;;
  esac
  shift
done

# Vérifier si ufw est installé sinon installation
if ! command -v ufw &> /dev/null; then
  echo "Installation de UFW..."
  sudo apt update && sudo apt install -y ufw
fi

# Vérifier si fail2ban est installé sinon installation
if ! command -v fail2ban-client &> /dev/null; then
  echo "Installation de Fail2ban..."
  sudo apt install -y fail2ban
else
  echo "Fail2ban est déjà installé."
fi

# Réinitialiser ufw si demandé
if [ "$RESET" = true ]; then
  echo "Réinitialisation des règles UFW..."
  sudo ufw --force reset
fi

# Politique par défaut : bloquer tout sauf sortie
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Autoriser HTTP et HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
echo "Ports HTTP (80) et HTTPS (443) autorisés."

# Autoriser SSH
if [ "$SSH_ENABLE" = true ]; then
  if [[ -n "$SSH_ALLOW_FROM" ]]; then
    echo "Autorisation SSH sur le port $SSH_PORT depuis $SSH_ALLOW_FROM"
    sudo ufw allow from "$SSH_ALLOW_FROM" to any port "$SSH_PORT" proto tcp
  else
    echo "Autorisation SSH sur le port $SSH_PORT pour tout le monde"
    sudo ufw allow "$SSH_PORT"/tcp
  fi
fi

# Activer ufw si pas déjà actif
if sudo ufw status | grep -q "Status: inactive"; then
  echo "Activation de UFW..."
  sudo ufw --force enable
else
  echo "UFW déjà activé."
fi

# Afficher l’état actuel de ufw
echo "État actuel du firewall :"
sudo ufw status verbose

# Configuration Fail2ban pour SSH avec le port custom
echo "Configuration de Fail2ban..."
sudo tee /etc/fail2ban/jail.local > /dev/null <<EOF
[DEFAULT]
bantime = 2h
findtime = 15m
maxretry = 5
backend = systemd

[sshd]
enabled = true
port = $SSH_PORT
filter = sshd
logpath = /var/log/auth.log
EOF

# Redémarrer et activer fail2ban
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban

echo "Script terminé. Vérifiez votre accès SSH avant de fermer la session."
