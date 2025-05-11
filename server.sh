#!/bin/bash

sudo su -

# how to create server:

echo "1- to install v2fly files"

bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

echo "2- open /usr/local/etc/v2ray/config.json and put this in it"

echo '{
  "inbounds": [
    {
      "port": 2526,
      "protocol": "vmess",
      "settings": {
        "clients": [

          {
                  "id": "7e955b63-2d08-5ba9-9fbc-7468786854ab",
                  "alterId": 0
          }

        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}' > /usr/local/etc/v2ray/config.json


echo "3- find my server ip"

founded_ip=$(ip -br a | awk '/^eth0/ { for (i=1; i<=NF; i++) if ($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\/[0-9]+$/) { split($i, a, "/"); print a[1]; exit } }')


echo "4- create a home directory for users and change the things in this json file"

cd /home && mkdir ammi

echo "{\"v\": \"2\",\"ps\": \"ammighorbani-2th\",\"add\": \"$founded_ip\",\"port\": \"2526\",\"id\": \"7e955b63-2d08-5ba9-9fbc-7468786854ab\",\"aid\": \"0\",\"net\": \"tcp\",\"type\": \"none\",\"host\": \"\",\"path\": \"\",\"tls\": \"\"}" > /home/ammi/ammi-vmess.json


echo "5- sanaie paneli"

bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)

echo "6- install base64"

apt install coreutils -y

echo "7- create v2ray config"

config_text=$(base64 -w 0 /home/ammi/ammi-vmess.json)

echo -n "vmess://$config_text"
