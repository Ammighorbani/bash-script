#!/bin/bash

# This script will change your nameserver in /etc/resolv.conf


sudo echo "nameserver 178.22.122.100" > /root/dns
sudo echo "nameserver 185.51.200.2" >> /root/dns
sudo echo "nameserver 185.55.226.26" >> /root/dns
sudo echo "nameserver 185.55.225.25" >> /root/dns

echo /root/dns& > cpprofile
cat .profile >> cpprofile
cat cpprofile > .profile


for (( ; ; ))
do 
      sudo cat /root/dns > /etc/resolv.conf
      sleep 180
      echo "" > /root/dns

done

