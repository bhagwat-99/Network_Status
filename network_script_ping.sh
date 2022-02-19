#!/bin/bash
#check for root
UID=$(id -u)
if [ x$UID != x0 ]
then
    #Beware of how you compose the command
    printf -v cmd_str '%q ' "$0" "$@"
    exec echo 'torizoncore' | sudo -S echo && sudo su -c "$cmd_str"
fi

#I am root
#and the rest of your commands

#echo 'torizoncore' | sudo -S echo && sudo su
#echo 'torizoncore' | sudo -S su && sudo su

#echo 'torizoncore' | sudo -S chown root:gpio /sys/class/gpio/unexport /sys/class/gpio/export

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
                internet_status=$(ping -q -c 1 -W 1 8.8.8.8 | awk '/received/ {print $4}')
                if [[ $internet_status = 1 ]]
                then
                        if [[ $led_state = OFF ]]
                        then

                                led_state=ON
                                echo 1 > /sys/class/gpio/gpio353/value
                                echo "connected to network"
                        else echo "connected to network"
                        fi
                else echo "Connected but no internet"
                echo 0 > /sys/class/gpio/gpio353/value

                fi

        else
                led_state=OFF
                echo 0 > /sys/class/gpio/gpio353/value
                echo "Not Connected"
        fi
        sleep 3
done

