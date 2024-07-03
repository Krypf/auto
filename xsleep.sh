# Bluetooth
/usr/local/bin/blueutil --power 0
osascript -e "set volume with output muted"
# Quit apps
# osascript app_list.scpt
osascript "auto/close_apps.scpt"

# only quit
# osascript -e 'quit app "Unshaky"'
# not quit
# osascript -e 'quit app "Terminal"'
# osascript -e 'quit app "DeepL"'

# sleep
pmset sleepnow
