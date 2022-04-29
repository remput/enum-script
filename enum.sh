#!/bin/bash

declare -a machineName
declare -a ipaddr

function questionnaire {
	read -p "Machine Name: " machineName
	read -p "IP Address: " ipaddr
	machineName+=($machineNameInput)
	ipaddr+=($ipaddrInput)
}

while true; do
	read -p "Are there any more machines? [y/n]: " yn
	case $yn in
		[Yy]* ) questionnaire;;
		[Nn]* ) break;;
		* ) echo "Please type Y or N.";;
	esac
done

set -- ${ipaddr[@]}
for i in "${machineName[@]}"
do
	mkdir ~/Desktop/$i
	nmap -sC -sV -oN ~/Desktop/$i/$1.log $1
	shift
done
