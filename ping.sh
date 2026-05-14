#!/bin/bash

LOGPATH=/var/log/pingscript.log


date >> $LOGPATH

echo "############################################" >> $LOGPATH
echo "############################################" >> $LOGPATH
echo "############################################" >> $LOGPATH

ping -c 2 8.8.8.8 >> $LOGPATH
