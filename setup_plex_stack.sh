#!/bin/bash

# This script is created for Raspberry Pi 5 running Raspberry Pi OS Bookworm
# Usage: sudo bash ./setup_plex_stack.sh <PATH_TO_WIREGUARD_CONF_FILE>

# Make sure external drive is connected and ready to be mounted
read -p "Is the external drive connected to the device? Y/n" -n 1 -r extdrv
echo

if [[ ! $extdrv =~ ^[Yy]$ ]]
then
    echo "Make sure the external drive is connected before executing the script."
    echo "Exiting..."
    exit 1
fi

# Update package lists and install them
echo "Updating package lists..."
sudo apt update

echo "Installing updates..."
sudo apt full-upgrade

# Install and start raspberry pi connect
echo "Installing Raspberry Pi Connect..."
sudo apt install rpi-connect
rpi-connect on

echo "Signing in to RPI Connect..."
rpi-connect signin

# Setup service to start RPI connect on boot

# Disable IPv6 on wireless interface

# Setup service to disable power_save on wireless interface
echo "Disabling power save on wlan..."
sudo cat > /etc/systemd/system/wlan0pwr.service << EOL
[Unit]
Description=Disable wlan0 powersave
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/sbin/iw wlan0 set power_save off

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl enable wlan0pwr

# Install wireguard
echo "Installing Wireguard..."
sudo apt install wireguard

# Create wireguard configuration file
echo "Creating wireguard configuration file..."
sudo cat $1 > /etc/wireguard/wg0.conf

# Setup service to start wireguard on boot
echo "Configuring Wireguard to start on boot..."
sudo systemctl enable wg-quick@wg0.service
sudo systemctl daemon-reload
sudo systemctl start wg-quick@wg0

# Install docker
echo "Installing Docker..."
curl -sSL https://get.docker.com | sh

# Install and start portainer
echo "Installing Portainer..."
sudo docker pull portainer/portainer-ce:latest
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
echo "Portainer is now available at localhost:9000 or http://<device-IP>:9000"

# Mount external hard drive

# Configure environment variables

# Start docker compose of plex stack

# Reboot
read -p "Setup complete. Device needs to be rebooted. Reboot now? Y/n" -n 1 -r rbt
echo

if [[ $rbt =~ ^[Yy]$ ]]
then
    echo "Rebooting..."
    sudo reboot
fi