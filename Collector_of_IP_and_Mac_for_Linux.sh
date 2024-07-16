#!/bin/bash 

dev=$(ip route show default | awk '{print $5}')
ip=$(ip -4 -o addr show $dev | awk '{print $4}')
ip=${ip%???}
mac=$(cat /sys/class/net/$dev/address | tr ':' '-' | tr [a-z] [A-Z])

while [ -z $user ]; do
	printf "\nEnter the user name.\n> "
	read user
done

while [ -z $userId ]; do
	printf "\nEnter the user ID.\n> "
	read userId
done 

printf "\nEnter the responsibility name.\nIf same with user, Press enter without typing.\n> "
read responsibility

if [ -z $responsibility ]; then
	responsibility=$user
	responsibilityId=$userId
else
	while [ -z $responsibilityId ]; do
		printf "\nEnter the responsibility ID.\n> "
		read responsibilityId
	done
fi

while [ -z $building ]; do
	printf "\nEnter the building number. (1 - E9 / 2 - IT4)\n> "
	read building
	if [ -z $building ]; then
		bilding=""
	elif [ $building == "1" ]; then
		building="E9"
	elif [ $building == "2" ]; then
		building="IT4"
	else
		building=""
	fi
done

while [ -z $room ]; do
	printf "\nEnter the room number.\n> "
	read room
done

printf "\nEnter the phone number.\nIf the phone number band is different, Press enter without typing.\n> "
read tmp
if [ -z $tmp ]; then
	while [ -z $phone ]; do
		printf "\nEnter the phone number.\n> "
		read phone
	done
else
	phone="053-950-$tmp"
fi

echo "$user;$userId;$responsibility;$responsibilityId;PC;$ip;$mac;$building;$room;$phone" >> IP_List_for_Linux.txt
