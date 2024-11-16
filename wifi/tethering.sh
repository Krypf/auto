#!/bin/zsh

# add /usr/sbin to PATH
export PATH=$PATH:/usr/sbin

networksetup -setairportpower en0 on

# Load the args.env file
export $(grep -v '^#' ~/auto/wifi/args.env | xargs)

# Connect to Wi-Fi using variables from args.env
networksetup -setairportnetwork en0 "$WIFI_SSID" "$WIFI_PASSWORD"

sleep 5

## IF CONNECTION FAILED ##
i=0
# Loop until connected to the specified Wi-Fi SSID
while (( i < 10 )); do
    # Get the current connected SSID
    CURRENT_SSID=$(networksetup -getairportnetwork en0 | awk -F ': ' '{print $2}')

    # Check if connected to the correct SSID
    if [[ "$CURRENT_SSID" == "$WIFI_SSID" ]]; then
        echo 0
        break
    else
        # Attempt to connect to Wi-Fi
        networksetup -setairportnetwork en0 "$WIFI_SSID" "$WIFI_PASSWORD"
        echo "Attempting to connect to Wi-Fi..."
        (( i++ ))
        sleep 5  # Wait a few seconds before retrying
    fi
done
