# This script is created for Raspberry Pi 5 running Raspberry Pi OS Bookworm

# Update package lists and install them
sudo apt update
sudo apt full-upgrade

# Install and start raspberry pi connect
sudo apt install rpi-connect
rpi-connect on
echo Sign in to RPI Connect
rpi-connect signin

# Setup service to start RPI connect on boot

# Install wireguard

# Setup service to start wireguard on boot

# Install docker

# Install portainer

# Mount external hard drive

# Configure environment variables

# Start docker compose of plex stack