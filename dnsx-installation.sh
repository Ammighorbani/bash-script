    install dnsx

filename: install dnsx

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


up toplevel finder

filename: toplevel dnsx tool

read domain
curl -s https://data.iana.org/TLD/tlds-alpha-by-domain.txt | tail -n +2 | tr 'A-Z'  'a-z' | sed "s/^/${domain}./" | dnsx -silent -r 8.8.4.4