mkdir -p /opt/zoraxy && cd /opt/zoraxy
sudo wget https://github.com/tobychui/zoraxy/releases/latest/download/zoraxy_linux_amd64 -O zoraxy
sudo chmod +x zoraxy

sudo ./zoraxy

sudo nano /etc/systemd/system/zoraxy.service

[Unit]
Description=Zoraxy Reverse Proxy
After=network.target

[Service]
Type=simple
ExecStart=/opt/zoraxy/zoraxy
Restart=always
User=root
WorkingDirectory=/opt/zoraxy

[Install]
WantedBy=multi-user.target


sudo systemctl enable --now zoraxy

sudo systemctl status zoraxy
