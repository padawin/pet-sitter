#!/bin/sh

mkdir -p images
previous=""
while :; do
	curr="$(pwd $PATH)/images/$(date +%y%m%d%H%M%S).png"
	echo "##############"
	imagesnap $curr > /dev/null
	if [ ! -z $previous ]
	then
		python pic.py "$previous" "$curr"
		different=$?
		if [ "$different" -eq 0 ]
		then
			rm $curr
		else
			echo "Images different, keep $curr"
		fi
	fi
	previous=$curr
	sleep 5
done
