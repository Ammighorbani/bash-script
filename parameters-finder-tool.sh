#!/bin/bash


# Giving domain
read -p "Enter your domain (mamadhacker.com): " domain


# Sending curl requeast to give data
curl "http://web.archive.org/cdx/search/cdx/?url=*.`echo -n $domain`/*&fl=original&collapse=urlkey" > $domain.txt


# Filtering parameters
cat $domain.txt | grep -oP '(?<=\?|&)[^=&#;]+' > $domain-parameters.txt
cat $domain-parameters.txt


# Removing useless files
rm $domain.txt