#!/bin/sh

mkdir -p images
previous=""
while :; do
	curr="$(pwd $PATH)/images/$(date +%y%m%d%H%M%S).png"
	echo "##############"
	if [ $(uname) == "Darwin" ]
	then
		imagesnap $curr > /dev/null
	else
		fswebcam -r 800x600 --png -1 $curr
	fi
	pictureTaken=$?

	if [ $pictureTaken -eq 0 ]
	then
		if [ -z $previous ]
		then
			previous=$curr
		else
			python pic.py "$previous" "$curr"
			different=$?
			if [ "$different" -eq 0 ]
			then
				rm $curr
			else
				echo "Images different, keep $curr"
				previous=$curr
			fi
		fi
	fi
	sleep 5
done
