#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Exiting..."
  exit 1
fi

echo "Creating user to run as the programs"
useradd rrms

echo "Creating directory for logs"
mkdir /var/log/rrms
mkdir /var/log/rrms/database/

echo "Creating directory for config information"
mkdir /etc/rrms

echo "Modifying permissions for newly created directories"
chown -R rrms:rrms /var/log/rrms
chown -R rrms:rrms /etc/rrms

echo "Installing dependencies for an arch based system"
sudo pacman -Sy --needed cmake make gcc boost boost-libs yaml-cpp

export CMAKE_POLICY_VERSION_MINIMUM=3.5
echo "Please note SOCI will be downloaded from the AUR from source!"
yay -S soci
