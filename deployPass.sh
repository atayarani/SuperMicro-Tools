#!/bin/bash

hosts=$@
jarfile="./ipmitool/SMCIPMITool.jar"
if [ ! -f $jarfile ]; then
    echo "Error: ${jarfile} Not Found"
    exit 1
fi

echo "Enter password:"
stty -echo
read PASS
stty echo

for host in $hosts; do 
	addUser="java -jar $jarfile"
	addUser="$addUser $(host $host | awk '{print $NF}') ADMIN ADMIN"
	addUser="$addUser user add 3 root $PASS 4"
	
	delUser="ipmitool -H $host -U root -P $PASS user set"
	delUser="$delUser password 2 $[$RANDOM*$RANDOM*$RANDOM]"
	
	$addUser
	$delUser
done
