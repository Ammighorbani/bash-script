#!/bin/bash


#install nuclei with golang on ubuntu

# Installing golang

sudo apt update
sudo apt install golang -y
go version

# Download the latest release
curl -s https://api.github.com/repos/projectdiscovery/nuclei/releases/latest \
| grep "browser_download_url.*linux_amd64.zip" \
| cut -d '"' -f 4 \
| wget -i -

# Unzip
unzip nuclei_*_linux_amd64.zip

# Move to a system-wide path
sudo mv nuclei /usr/local/bin/

# Verify installation
nuclei -version

# Installing nuclei file with go
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Exporting go in PATHs
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

# Updating nuclei templates
nuclei -update-templates

# Quick test
nuclei -u https://example.com