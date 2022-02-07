#!/bin/bash
led_state=OFF
while true
do
        network_status=$(nmcli -t -f STATE g)

        if [[ $network_status = connected ]]
        then
                internet_status=$(ping -q -c 1 -W 1 8.8.8.8 | awk '/received/ {print $4}')
                if [[ $internet_status = 1 ]]
                then
                        if [[ $led_state = OFF ]]
                        then

                                led_state=ON
                                echo "connected to network"
                        else echo "connected to network"
                        fi
                else echo "Connected but no internet"
                fi

        else
                led_state=OFF
                echo "Not Connected"
        fi
        sleep 3
done

