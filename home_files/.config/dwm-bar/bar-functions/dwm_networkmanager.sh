#!/bin/sh

# A dwm_bar function to show the current network connection/SSID, private IP, and public IP using NetworkManager
# GNU GPLv3

# Dependencies: NetworkManager, curl

OLD_CONNAME=""
PUBLIC=""

dwm_networkmanager () {
    CONNAME=$(nmcli -a | grep 'Wired connection' | awk 'NR==1{print $1}')
    if [ "$CONNAME" = "" ]; then
        CONNAME=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -c 5-)
    fi

    PRIVATE=$(nmcli -a | grep 'inet4' | awk '{print $2}' | grep -v -E '(127|172)' | head -n 1)

    # only refetch ip when connection name changed
    if [ "$CONNAME" != "$OLD_CONNAME" ]; then
        PUBLIC=$(curl -s https://ipinfo.io/ip)
        OLD_CONNAME="$CONNAME"
    fi

    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "${SEP1}🌐 ${CONNAME} ${PRIVATE} ${PUBLIC}${SEP2}"
    else
        printf "${SEP1}NET ${CONNAME} ${PRIVATE} ${PUBLIC}${SEP2}"
    fi
}

dwm_networkmanager
