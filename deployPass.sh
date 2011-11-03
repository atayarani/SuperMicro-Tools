#!/bin/bash

hosts=$@
echo "Enter password:"
stty -echo
read PASS
stty echo

for host in hosts; do 
	addUser="java -jar /home/radon01/ali/scratch/smc/ipmitool/SMCIPMITool.jar"
	addUser="$addUser $(host $HOST | awk '{print $NF}') ADMIN ADMIN"
	addUser="$addUser user add 3 root $PASS 4"
	
	delUser="ipmitool -H $HOST -U root -P $PASS user set"
	delUser="$delUser password 2 $[$RANDOM*$RANDOM*$RANDOM]"
	
	$addUser
	$delUser
done