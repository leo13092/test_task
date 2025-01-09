#!/bin/bash
# Update and install nginx
apt-get update -y
apt-get install -y nginx

# Format and mount EBS volume (assuming device /dev/xvdf)
mkfs -t ext4 /dev/xvdf
mkdir -p /data
mount /dev/xvdf /data
echo "/dev/xvdf /data ext4 defaults 0 0" >> /etc/fstab

# Start nginx
systemctl start nginx
systemctl enable nginx
