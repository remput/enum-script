#!/bin/bash

declare -a machineName
declare -a ipaddr

#Asks the user to input the machine name and the IP address, appends to array
function questionnaire {
	read -p "Machine Name: " machineNameInput
	read -p "IP Address: " ipaddrInput
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

#Runs nmap scan individually, creates a folder with the Machine Name and sends nmap output to (ip-address).log in that folder
set -- ${ipaddr[@]}
for i in "${machineName[@]}"
do
	mkdir ~/Desktop/$i
	nmap -sC -sV -oN ~/Desktop/$i/$1.log $1
	shift
done
