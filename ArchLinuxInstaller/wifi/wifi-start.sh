#!/bin/bash

networks=('SSID-Name-1' 'SSID-Name-1')
networksPasswords=('SSID-Pass-1' 'SSID-Pass-2')




optionsFound=0


while getopts ":n:l" opt; do
	case $opt in
		n) networkCode="$OPTARG"
			optionsFound=1
		;;
		l) echo -e 'List of available networks: '${networks[*]}'\n\n'
			exit
		;;
	esac
done


echo -e 'Usage:'
echo -e './wifi-start "NetworkName" "Password"'
echo -e '-n <NetworkCode>    For example aep or neverland. In this case you do not need NetworkName and Passsword.'
echo -e '-l                  Show the list of Network codes.\n\n'


if [ ${optionsFound} -eq 0 ]
then 
	networkNameString=$1
	networkPasswordString=$2
	errorString='Sorry you need to send the NetworkName and Password\n\n'
	
	if [ -z "$networkNameString" ]
	then
		echo -e ${errorString}
		exit
	fi

	if [ -z "$networkPasswordString" ]
	then
		echo -e ${errorString}
		exit
	fi

elif [ ${optionsFound} -eq 1 ]
then
	isNetwork=-1
	for i in "${!networks[@]}"
	do
		if [[ "${networks[$i]}" = "${networkCode}" ]]
		then
			isNetwork=${i}
			networkNameString=${networks[$i]}
			networkPasswordString=${networksPasswords[$i]}
			break;
		fi
	done

	if [ ${isNetwork} -eq -1 ]
	then
		echo -e 'Sorry, we do not found your network. Try: '${networks[*]}'\n\n'
		exit
	fi
fi


ip link set wlp3s0 up
ip link show wlp3s0
iw dev wlp3s0 set type ibss
echo 'wpa_supplicant -D 180211,wext -i wlp3s0 -c <(wpa_passphrase "'${networkNameString}'" "'${networkPasswordString}'")'
wpa_supplicant -D 180211,wext -i wlp3s0 -c <(wpa_passphrase "${networkNameString}" "${networkPasswordString}")
