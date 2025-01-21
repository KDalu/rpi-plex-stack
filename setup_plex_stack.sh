# This script is created for Raspberry Pi 5 running Raspberry Pi OS Bookworm

# Usage: setup_plex_stack.sh <PATH_TO_WIREGUARD_CONF_FILE>

# Update package lists and install them
echo Updating package lists...
sudo apt update

echo Installing updates...
sudo apt full-upgrade

# Install and start raspberry pi connect
echo Installing Raspberry Pi Connect...
sudo apt install rpi-connect
rpi-connect on

echo Signing in to RPI Connect...
rpi-connect signin

# Setup service to start RPI connect on boot

# Disable IPv6 on wireless interface

# Install wireguard
echo Installing Wireguard...
sudo apt install wireguard

# Create wireguard configuration file
echo Creating wireguard configuration file...
sudo cat $1 > /etc/wireguard/wg0.conf

# Setup service to start wireguard on boot
echo Configuring Wireguard to start on boot...
sudo systemctl enable wg-quick@wg0.service
sudo systemctl daemon-reload
sudo systemctl start wg-quick@wg0

# Install docker

# Install portainer

# Mount external hard drive

# Configure environment variables

# Start docker compose of plex stack