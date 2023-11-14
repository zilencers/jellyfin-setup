#!/bin/bash

# Update the system
dnf -y update

# Tell SELinux it is ok to allow systemd to manipulate its Cgroups configuration
setsebool -P container_manage_cgroup true

# Make a copy of fstab before making changes
cp /etc/fstab ~/fstab

# Mount NFS shares
# NFS_SERVER_IP:EXPORTED_DIRECTORY MOUNT_POINT
echo "192.168.0.10:/movies /mnt/movies  nfs      defaults    0       0 " >> /etc/fstab
echo "192.168.0.10:/shows /mnt/shows  nfs      defaults    0       0 " >> /etc/fstab
echo "192.168.0.10:/music /mnt/music  nfs      defaults    0       0 " >> /etc/fstab
echo "192.168.0.10:/photos /mnt/photos  nfs      defaults     0     0" >> /etc/fstab   

# Create local media directories
mkdir -p /etc/opt/jellyfin/config
mkdir -p /var/cache/jellyfin/cache
mkdir -p /mnt/{movies,shows,music,photos}
mkdir -p /srv/local/media/{dvr,movies,shows,music,photos}
