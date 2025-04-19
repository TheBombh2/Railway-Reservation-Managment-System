#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Exiting..."
  exit 1
fi

echo "Creating user to run as the programs"
sudo useradd rrms

echo "Creating directory for logs"
mkdir /var/log/rrms
sudo chown -R rrms:rrms /var/log/rrms
