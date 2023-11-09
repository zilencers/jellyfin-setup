#!/bin/bash

if [ ! $1 ] || [ ! $2 ]; then
   echo "Missing argument"
   echo "Usage: setup.sh [SSID] [PASSWORD]" 
   exit 1
fi

if [ $(echo whoami) != "root" ]; then
   echo "Permission Denied"
   exit 1
fi

# Update the system
dnf -y update

# Create jellyfin group
groupadd -U conman jellyfin

# Make media directories
mkdir -p /etc/opt/jellyfin/config
mkdir -p /var/cache/jellyfin/cache
mkdir -p /srv/jellyfin/media/{movies,shows,music,photos}

# Change owner and group
chown -R root:jellyfin /srv/jellyfin
chown -R root:jellyfin /etc/opt/jellyfin
chown -R root:jellyfin /var/cache/jellyfin

# Setup wifi connection
ENABLED=$(nmcli radio wifi)

# If wifi radio is not enabled, turn it on
[[ $ENABLED != "enabled" ]] && nmcli radio wifi on

# Connect to wifi network
nmcli dev wifi connect $1 password $2

# Clear bash history
history -c
