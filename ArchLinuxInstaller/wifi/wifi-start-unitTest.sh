#!/bin/bash

echo -e '\n\n\n\n=====================================\n'

echo -e '-------------------------------------'
echo -e '[./wifi-start.sh "SSID-Name-1" "SSID-Pass-1"]'
echo -e '-------------------------------------'
./wifi-start.sh "SSID-Name-1" "SSID-Pass-1"

echo -e '-------------------------------------'
echo -e '[./wifi-start.sh -n SSID-Name-2]'
echo -e '-------------------------------------'
./wifi-start.sh -n 'SSID-Name-2'

echo -e '-------------------------------------'
echo -e '[./wifi-start.sh -l]'
echo -e '-------------------------------------'
./wifi-start.sh -l

echo -e '-------------------------------------'
echo -e '[./wifi-start.sh]'
echo -e '-------------------------------------'
./wifi-start.sh

echo -e '-------------------------------------'
echo -e '[./wifi-start.sh ]'
echo -e '-------------------------------------'
./wifi-start.sh 

echo -e '-------------------------------------'
echo -e '[./wifi-start.sh "oneParam"]'
echo -e '-------------------------------------'
./wifi-start.sh "oneParam"

echo -e '-------------------------------------'
echo -e '[./wifi-start.sh -n Penny]'
echo -e '-------------------------------------'
./wifi-start.sh -n Penny

echo -e '-------------------------------------'
echo -e '[./wifi-start.sh -n notExistThisNetwork]'
echo -e '-------------------------------------'
./wifi-start.sh -n notExistThisNetwork

echo -e '=====================================\n'
