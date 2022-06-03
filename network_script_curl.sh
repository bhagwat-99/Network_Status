#!/bin/bash

echo 353 > /sys/class/gpio/export

echo "out" > /sys/class/gpio/gpio353/direction
echo 0 > /sys/class/gpio/gpio353/value

led_state=OFF
while true
do
    internet_status=$(curl --connect-timeout 5 -sI http://www.google.com | awk '/200/ {print $2}')

    if [[ $internet_status = 200 ]]
    then
        if [ $led_state = OFF ]
        then
            led_state=ON
            echo 1 > /sys/class/gpio/gpio353/value
            echo "connected"
        fi
    else
        echo 0 > /sys/class/gpio/gpio353/value
        echo "disconnected"
        led_state=OFF
    fi
sleep 1
done
