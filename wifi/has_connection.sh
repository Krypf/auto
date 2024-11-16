#!/bin/zsh

# Check Wi-Fi connection status
wifi_status=$(networksetup -getairportpower en0 | grep -o "On")

if [[ "$wifi_status" == "On" ]]; then
    echo 1
else
    echo 0
fi

# Wi-Fi 接続を確認
# Linux
# if nmcli -t -f WIFI g | grep -q "enabled"; then
#     echo 1
# else
#     echo 0
# fi
