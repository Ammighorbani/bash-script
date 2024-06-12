#!/bin/bash

# This script will give your path and count a word for you

# This line will give your PATH
read -p "Enter your PATH: " PATH_NAME

# This line will do a for loop on your input
for file in $PATH_NAME; do

	# Here we check your input with your own path
	if [ "${file}" == "[into/your/PATH]" ]; then

		# This line will count your own word in your own PATH
		COUNT=$(grep -c ["your-word"] ["into/your/path"])

		# This line will tell the count of your own word
		echo "["your-word"] we found count is ${COUNT}"
		break
	fi
done
