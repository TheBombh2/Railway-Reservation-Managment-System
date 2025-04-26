#!/bin/bash

if ! grep -qi "arch" /etc/os-release; then
    echo "This install script is only supported on Arch Linux. Either install Arch Linux or manually download the dependencies for the project in dependencies.txt. You can also use the precompiled binaries. You will need to install the database management systems (Redis/Valeky and MariaDB/MySQL)."
    return -1

IsDBInstalled() {
    if command -v mariadb > /dev/null || command -v mysql > /dev/null; then
        return 0 # Either MariaDB or MySQL is installed...even though I support MariaDB more
    else
        return 1 # None are installed
    fi
}

echo "Creating user to run as the programs"
sudo useradd -M -s /bin/nologin rrms

echo "Creating directory for logs"
sudo mkdir /var/log/rrms
sudo mkdir /var/log/rrms/database/

echo "Creating directory for config information"
sudo mkdir /etc/rrms

echo "Modifying permissions for newly created directories"
sudo chown -R rrms:rrms /var/log/rrms
sudo chown -R rrms:rrms /etc/rrms

echo "Installing dependencies for an arch based system"
sudo pacman -Sy --needed --noconfirm cmake make gcc boost boost-libs yaml-cpp valkey hiredis
sudo systemctl enable --now valkey.service
sudo sysctl vm.overcommit_memory=1 # Allow valkey to overcommit memory for performance

if ! IsDBInstalled; then 
    echo "Neither MariaDB or MySQL are installed. The script will not install MariaDB with default settings"
    echo "Note: It is recommended to read the arch wiki to improve its security or change its data location"
    sudo pacman -Sy --needed --noconfirm mariadb
    sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    sudo systemctl enable --now mariadb.service

echo "NOTE:"
echo "IF IT IS YOUR FIRST TIME RUNNING VALKEY, THEN THERE ARE SOME CONFIGURATIONS THAT MUST BE DONE"
echo "FIRSTLY, YOU CAN OPTIONALLY PROVIDE A PASSWORD IN ITS CONFIGURATION FILE AT THE 'requirepass' LINE"
echo "SECONDLY, YOU HAVE TO BIND THE IP ADDRESS OF THE SERVER ON WHICH THE BACKEND AND VALKEY WILL BE HOSTED ON IN THE 'bind' SECTION OF THE CONFIG FILE"
echo "THE CONFIG FILE IS LOCATED AT /etc/valkey/valkey.conf"

export CMAKE_POLICY_VERSION_MINIMUM=3.5
echo "Please note SOCI (MariaDB database wrapper), redis-plus-plus (redis database wrapper), and cpr (HTTP requests library wrapper for libcurl) will be downloaded from the AUR from source!"
yay -S soci redis-plus-plus --noconfirm
yay -S cpr --noconfirm --mflags="--nocheck" # --nocheck is due a bug with the latest version of curl

echo "Now, the project (microservices backend) will start compiling"
echo "This might take a few minutes depending on your CPU's strength"
cmake -S . -B ./build/ -DCMAKE_BUILD_TYPE=release
cd ./build/
sudo make install
sudo systemctl daemon-reload
sudo systemctl enable --now rrms-authorization.service
sudo systemctl enable --now rrms-employee.service
