#!/bin/bash

# update and upgrade our VPS

apt update && apt upgrade -y

# install some packages i need on my VPS

apt install apache2 -y && apt install mysql-server -y

# install plocate to find our file path

apt install plocate -y && updatedb

# clone my repo in github

git clone https://github.com/Ammighorbani/bash-script

cd bash-script


# finding our files path

serversh_location=`locate server.sh`
nuclei_installationsh_location=`locate nuclei-installation.sh`
dnsx_installationsh_location=`locate dnsx-installation.sh`

# change some files permission

chmod +x $serversh_location && chmod +x $nuclei_installationsh_location && chmod +x $dnsx_installationsh_location


# run server.sh to setup VPN server

echo "runnig server.sh ...."
. $serversh_location


# run nuclei-installation.sh to install nuclei

echo "runnig nuclei-installation.sh ..."
. $nuclei_installationsh_location

# run dnsx-installation.sh to install dnsx

echo "runnig dnsx-installation.sh ...."
. $dnsx_installationsh_location
