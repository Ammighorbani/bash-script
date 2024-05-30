#!/bin/bash

# This script will create a mariaDB data base for you

# This command will install mariadb for you
sudo apt upgrade && sudo apt install mariadb-server -y

# This command will open secure installation menu for you
sudo mariadb-secure-installation

# This three lines will give your user-name, user-pass and your host ip

read -p "Enter your user: " USER
read -s -p "Enter your password: " PASS
read -p "Enter your host name: " HOST 

# NOTE: If you are runing this file into your server you can write "localhost" for HOST

# Creating db

sudo mariadb -u$USER -p$PASS -h$HOST -e"SHOW DATABASES;" && read -p "Create database: " Cdb &&
       	sudo mariadb -u$USER -e "$Cdb" && sudo mariadb -u$USER -e "SHOW DATABASES;" &&
	read -p "Enter your database name: " db_NAME && read -p "Create your table: " CTABLE &&
	sudo mariadb -u$USER -D$db_NAME -e "$CTABLE;" && sudo mariadb -u$USER -D$db_NAME -e "SHOW TABLES" && 
	read -p "Insert your data into table: " IDATA && sudo mariadb -u$USER -D$db_NAME -e "$IDATA;" &&
	sudo su -u$USER -D$db_NAME -e "SHOW TABLES"
	read -p "Choose your table: " TNAME && sudo mariadb -u$USER -D$db_NAME -e "SELECT * FROM $TNAME"

echo "
      ###################################################################################################
      #                                                                                                 #
      #                                 db DONE and Welcome to db                                       #
      #                                 db DONE and Welcome to db                                       #
      #                                 db DONE and Welcome to db                                       #
      #                                 db DONE and Welcome to db                                       #
      #                                 db DONE and Welcome to db                                       #
      #                                                                                                 #
      ###################################################################################################
      "
