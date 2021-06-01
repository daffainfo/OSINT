#!/bin/bash
# OSINT tools
LISTS=$1
UNAME=$2

if [[ ! -f ${LISTS} ]]; then
	echo "ERROR: ${LISTS} not found"
	echo "usage: bash $0 list.txt"
	exit
fi

for SITE in $(cat $LISTS);
do
	link=$(echo $SITE | sed "s/uname/$2/")
	response=$(curl -I $link 2>/dev/null | head -n 1 | cut -d$' ' -f2)
    if [[ $response =~ '200' ]]; then
		echo -e "\e[32m[+] FOUND: ${link}"
	else
		echo -e "\e[31m[-] NOT FOUND: ${link}"
	fi
done