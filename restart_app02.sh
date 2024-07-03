#!/bin/zsh

# Specify the name or command of the application to restart
#NAME_APP="your_application"

# Read user input for the application name
read -p "Enter the name or command of the application: " _input
interval="5";

# echo "$_input"
# Check if the input is "brave" and set the NAME_APP accordingly
if [[ "$_input" == "brave" || "$_input" == "bb" ]]; then
	NAME_APP="Brave Browser";
elif [[ "$_input" == "firefox" || "$_input" == "ff" ]]; then
    NAME_APP="Firefox";
    # interval="5";
elif [[ "$_input" == "code" || "$_input" == "vs" ]]; then
    NAME_APP="Visual Studio Code";
else
    echo "Unsupported application: $_input"
    exit 1
fi

# Set the path of the app
APP_PATH="/Applications/$NAME_APP.app"
echo "We open or reopen $NAME_APP placed on $APP_PATH\n"

# Function to restart the application

restart_os() {
    echo "Restarting $NAME_APP..."
    osascript -e 'quit app "$NAME_APP"'
    sleep "$interval"
    open "$APP_PATH"
}

restart_os

