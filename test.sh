#!/bin/bash

#reading serial ID
#SerialID=$(cat /etc/entomologist/ento.conf | awk '/SERIAL_ID/ {print $2} ' | tr -d '",')
SerialID=D0590

#aws url to ping request
address='https://ush9tkb8hj.execute-api.us-west-2.amazonaws.com/hbeat?deviceId='$SerialID

boot='https://ush9tkb8hj.execute-api.us-west-2.amazonaws.com/boot?deviceId='$SerialID

net_status=not_connected
net_status=$(curl -s --connect-timeout 5  $boot | tr -d '"')

while true
do
  if [ $net_status = "OK" ]
  then
      echo $net_status
      break
  fi
  echo "IN while"
  sleep 1
done

echo "connected to internet"