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
