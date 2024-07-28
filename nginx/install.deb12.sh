#!/usr/bin/env bash

# Requirements
# Debian 12 bookworm
# Run this as root
#
# Uses Debian repos - nginx v1.22.1 at time of writing
# Official nginx repos may be added in the future
# These repos have newer releases and creat an nginx user
# https://nginx.org/en/linux_packages.html#Debian

# NOTE: You'll need to upload your TLS/SSL key and certificate separately
# The easiest way is to do this before running this script
# Filenames: /etc/ssl/STAR_ottojs_org.[key,crt]

# Upgrade System
apt-get update;
apt-get dist-upgrade -y;
apt-get autoremove;

# Clone Repo
apt-get install -y git;
git clone https://github.com/ottojs/ottojs.org.git;

# Install Nginx
apt-get install -y nginx;
cp ./ottojs.org/nginx/default.conf /etc/nginx/sites-available/default;

# Make Default Site
mkdir -p /var/www/default/public/;
cat << EOF > /var/www/default/public/index.html;
Default Site
EOF

# Copy Website Files
mkdir -p /var/www/ottojs.org/;
cp -r ./ottojs.org/public /var/www/ottojs.org/;

# Remove Repo Files
# No longer needed
rm -r ./ottojs.org/;

# Reboot
reboot;
