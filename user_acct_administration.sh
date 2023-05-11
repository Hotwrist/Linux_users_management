#!/bin/bash

#-------------------------------------------------------------------------
# Author: Odey John Ebinyi aka Hotwrist
# Twitter: @i_am_giannis
# Description:  This BASH script was created by me to
#		help Lnux System Administrators with their
#		daily routine of handling user accounts creation,
#		deletion, and other functions!.
# Date: Thursday, 11th April, 2023
#-------------------------------------------------------------------------

clear
echo

GREEN="\033[1;32m"
WHITE="\033[0;37m"
BLUE="\033[0;34m"
RED="\033[1;31m"

#figlet -f ivrit "nimda metsys" | lolcat -a -d 7
figlet -f maxiwi "System Admin" | lolcat -a -d 7

echo
echo -e "${BLUE}Author:${WHITE} Odey John Ebinyi (c) 2023"
echo -e "${BLUE}Twitter:${WHITE} @i_am_giannis"
echo

#=================================== FUNCTIONS ==================================================
function add_new_user {
	clear
	read -p "User's login name: " login_name
	read -p "User's comment field: " comment
	sudo useradd -m $login_name -c  "$comment"

	sudo passwd $login_name

	if [ $? -eq 10 ]; then
		echo "Error: Passwords did not match"
	fi
}

function delete_user {
	clear
	read -p "User login name: " login_name

	if [ -n $login_name ]; then
		user_exist=$(cat /etc/passwd | grep -w $login_name)
		if [ $? -eq 1 ]; then
			echo -e "Sorry, the user:${RED} $login_name${WHITE}, does not exist!."
		else
			sudo userdel -r $login_name 2> /dev/null
		fi
	fi
}

function lock_user_account {
	clear
	read -p "User's login name: " login_name

	user_exist=$(cat /etc/passwd | grep -w $login_name)

	if [ $? -eq 1 ]; then
		echo -e "Sorry, the user: ${RED} $login_name${WHITE}, does not exist!."
	else
		sudo usermod -L $login_name
	fi
}

function unlock_user_account {
	clear
	read -p "User's login name: " login_name

	user_exist=$(cat /etc/passwd | grep -w $login_name)

	if [ $? -eq 1 ]; then
		echo -e "Sorry, the user: ${RED} $login_name${WHITE}, does not exist!."
	else
		sudo usermod -U $login_name
	fi
}

function search_for_user {
	clear
	read -p "Username of the user: " username

	result=$(cat /etc/passwd | grep -w -i $username)

	if [ $? -ne 1 ]; then
		echo "Found a user: "
		echo -e "${GREEN}$result${WHITE}"
	else
		echo -e "${RED}User not found{WHITE}"
	fi
}

function menu {
	echo -e "\t\t\t${GREEN}System Admin Menu${WHITE}\n"
	echo -e "\t1. Add a New User"
	echo -e "\t${RED}2. Delete a User${WHITE}"
	echo -e "\t3. Lock User Account"
	echo -e "\t4. Unlock User Account"
	echo -e "\t5. Search For a User"
	echo -e "\t0. Exit Program"
	echo -en "\nEnter option: "

	read -n 1 option
}

while [ 1 ]
do
	menu

	case $option in
		0) echo -e "${GREEN}\n\n-Bye${WHITE}"
		   sleep 1
		   break;;
		1) add_new_user;;
		2) delete_user;;
		3) lock_user_account;;
		4) unlock_user_account;;
		5) search_for_user;;
		*) clear
	   	   echo -e "${RED}ERROR:{$WHITE} Wrong Selection";;
	esac
	echo -en "\n\n\t\t\tHit any key to continue\n"
	read -n 1 line
	clear
done
clear

#================================
#END				|
#I go by the moniker: Hotwrist	|
#================================
