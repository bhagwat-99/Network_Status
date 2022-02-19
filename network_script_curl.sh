#!/bin/bash

# exporting the gpio4.IO01 - 480 - 32 * 4 + 1 = 353
echo 353 > /sys/class/gpio/export


#set the direction of pin
echo "out" > /sys/class/gpio/gpio353/direction


#set the pin
echo 0 > /sys/class/gpio/gpio353/value


led_state=OFF
while true
do
        network_status=$(nmcli -t -f STATE g)

        if [[ $network_status = connected ]]
        then
            	internet_status=$(curl -sI http://www.google.com | awk '/200/ {print $2}')
                if [[ $internet_status = 200 ]]
                then
                    	if [[ $led_state = OFF ]]
                        then
                            	led_state=ON
                                echo 1 > /sys/class/gpio/gpio353/value
                                echo "connected to network"
                        fi
                else
                        echo "Connected but no internet"
                        echo 0 > /sys/class/gpio/gpio353/value
                fi
        else
                led_state=OFF
                echo 0 > /sys/class/gpio/gpio353/value
                echo "Not Connected"
        fi
done
