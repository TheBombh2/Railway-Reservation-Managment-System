#!/bin/bash

if ! grep -qi "arch" /etc/os-release; then
    echo "\e[31mThis install script is only supported on Arch Linux. Either install Arch Linux or manually download the dependencies for the project in dependencies.txt. You can also use the precompiled binaries. You will need to install the database management systems (Redis/Valeky and MariaDB/MySQL).\e[0m"
    return -1
fi

IsDBInstalled() {
    if command -v mariadb > /dev/null || command -v mysql > /dev/null; then
        return 0 # Either MariaDB or MySQL is installed...even though I support MariaDB more
    else
        return 1 # None are installed
    fi
}

echo -e "\e[31mCreating user to run as the programs\e[0m"
sudo useradd -M -s /bin/nologin rrms

echo -e "\e[31mCreating directory for logs\e[0m"
sudo mkdir /var/log/rrms
sudo mkdir /var/log/rrms/database/

echo -e "\e[31mCreating directory for config information\e[0m"
sudo mkdir /etc/rrms

echo -e "\e[31mModifying permissions for newly created directories\e[0m"
sudo chown -R rrms:rrms /var/log/rrms
sudo chown -R rrms:rrms /etc/rrms

echo -e "\e[31mInstalling dependencies for an arch based system\e[0m"
sudo pacman -Sy --needed --noconfirm cmake make gcc boost boost-libs yaml-cpp valkey hiredis
sudo systemctl enable --now valkey.service
sudo sysctl vm.overcommit_memory=1 # Allow valkey to overcommit memory for performance

if ! IsDBInstalled; then 
    echo -e "\e[33mNeither MariaDB or MySQL are installed. The script will not install MariaDB with default settings\e[0m"
    echo -e "\e[33mNote: It is recommended to read the arch wiki to improve its security or change its data location\e[0m"
    sudo pacman -Sy --needed --noconfirm mariadb
    sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    sudo systemctl enable --now mariadb.service
fi

echo -e "\e[33mOTE:"
echo -e "IF IT IS YOUR FIRST TIME RUNNING VALKEY, THEN THERE ARE SOME CONFIGURATIONS THAT MUST BE DONE"
echo -e "FIRSTLY, YOU CAN OPTIONALLY PROVIDE A PASSWORD IN ITS CONFIGURATION FILE AT THE 'requirepass' LINE"
echo -e "SECONDLY, YOU HAVE TO BIND THE IP ADDRESS OF THE SERVER ON WHICH THE BACKEND AND VALKEY WILL BE HOSTED ON IN THE 'bind' SECTION OF THE CONFIG FILE"
echo "THE CONFIG FILE IS LOCATED AT /etc/valkey/valkey.conf\e[0m"

export CMAKE_POLICY_VERSION_MINIMUM=3.5
echo -e "\e[33mPlease note SOCI (MariaDB database wrapper), redis-plus-plus (redis database wrapper), and cpr (HTTP requests library wrapper for libcurl) will be downloaded from the AUR from source!\e[0m"
yay -S soci redis-plus-plus --noconfirm
yay -S cpr --noconfirm --mflags="--nocheck" # --nocheck is due a bug with the latest version of curl

echo "Now, the project (microservices backend) will start compiling\e[0m"
echo "This might take a few minutes depending on your CPU's strength\e[0m"
cmake -S . -B ./build/ -DCMAKE_BUILD_TYPE=release
export MAKEFLAGS="-j$(nproc)"
cd ./build/
sudo make install
sudo systemctl daemon-reload
sudo systemctl enable --now rrms-authorization.service
sudo systemctl enable --now rrms-employee.service
sudo systemctl enable --now rrms-reservation.service
