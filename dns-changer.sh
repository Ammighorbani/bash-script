#!/bin/bash

# This script will change your nameserver in /etc/resolv.conf
# First touch a file and write this nameservers in it
# nameserver 178.22.122.100
# nameserver 185.51.200.2
# nameserver 185.55.226.26
# nameserver 185.55.225.25

# Write this file PATH into .profile and use "&" after that
# example: /root/scripts/dnsch&


for (( ; ; ))
do 
      sudo cat ["nameserver-file"] > /etc/resolv.conf
      sleep 180

done

