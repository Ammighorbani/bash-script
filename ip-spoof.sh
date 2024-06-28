#!/bin/bash

# TO save your orginal ip addr
sudo ip addr show > /root/org.ip-eth0


# Do loop to cahnge lots of ips

for i in {1..255}
do
        # To clean your ip list
        ip addr flush dev eth0

        # To show your ip list
        sudo ip a

        # To down your ip service
        sudo ip link test down

        # To Add ip into your ip list
        sudo ip addr add 192.168.1.$i/24 dev eth0

        # To up your ip service
        sudo ip link test up

        # To show which ip is trying to do nmap
        echo 192.168.1.$i

        # To show your ip list
        sudo ip a

        # To do nmap on your target ip
        sudo nmap ["Target-Ip"] -p ["Srvs-Ip"]

done
