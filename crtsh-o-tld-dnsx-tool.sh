
# Extracting data from crt.sh for certificate search with same organization and do tld+1 and updomain DNSX tool on it.

#!/bin/bash

echo "Enter your domain (domain.com)"
read domain

echo "Enter your organization in url encoded format"
read organization


# chained command

curl "https://crt.sh/?O=`echo $organization`&output=json" > $domain-cert.json && ls | grep $domain-cert.json | 
cat $domain-cert.json | jq -r ".[].common_name" | sort -u > $domain-sorted.txt

echo "you can do more customize on your output with unfurl tool"


read -p "Do you want to use regex? (Y/N): " regexyn

# Check if input is Y or y

if [[ "$regexyn" == "Y" || "$regexyn" == "y" ]]; then

    read -p "Enter regex parameter: " regexParam

    cat $domain-sorted.txt | grep $regexParam | wc

    echo "You entered regexParam: $regexParam"

    cat $domain-sorted.txt | grep $regexParam > $domain-greped.txt

    rm $domain-sorted.txt

else

    echo "Skipping regex parameter..."

fi


# check for existing file

file=""

if [[ -f "${domain}-greped.txt" ]]; then
            file="${domain}-greped.txt"
    elif [[ -f "${domain}-sorted.txt" ]]; then
                file="${domain}-sorted.txt"
        else
                    echo "No file found for domain: $domain"
                        exit 1
fi

# doing dnsx

echo "Please wait doing dnsx..."

cat $file | dnsx -silent -r 8.8.4.4 >> chupdomains

cat chupdomains


read -p "wanna remove useless files?" removeyn
if [[ "$removeyn" == "Y" || "$removeyn" == "y" ]]; then

    rm $domain-*.*

else

    echo "Kipping useless files"

fi