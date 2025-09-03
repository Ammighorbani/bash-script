#!/bin/bash

# update system
sudo apt update -y && apt upgrade -y && apt install jq -y

#installing golang
snap install go --classic

#exporting golang to our system paths
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

#checking golang version
go version


sudo go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

dnsx -h