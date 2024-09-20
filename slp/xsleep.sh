# Bluetooth
#/usr/local/bin/blueutil --power 0
osascript -e "set volume with output muted"
# Quit apps
osascript "~/auto/slp/close_apps.scpt"

# sleep
pmset sleepnow
