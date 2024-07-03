#!/bin/bash
# https://chat.openai.com/c/cedbd932-3df7-4c9e-96b2-1840b9356516

# Specify the name or command of the application to restart
#NAME_APP="your_application"

# Read user input for the application name
read -p "Enter the name or abbreviation of the application: " _input
interval="4";

# echo "$_input"
# Check if the input is ready and set the NAME_APP and PROCESS accordingly
if [[ "$_input" == "brave" || "$_input" == "bb" ]]; then
    sh ~/auto/restart_brave.sh
    exit 0
elif [[ "$_input" == "firefox" || "$_input" == "ff" ]]; then
    NAME_APP="Firefox";
    PROCESS="Firefox";
    # interval="5";
elif [[ "$_input" == "deepl" || "$_input" == "ll" ]]; then
    NAME_APP="DeepL";
    PROCESS="DeepL";
    # interval="5";
elif [[ "$_input" == "jabref" || "$_input" == "jj" ]]; then
    NAME_APP="JabRef";
    PROCESS="JabRef";

elif [[ "$_input" == "word" || "$_input" == "ww" ]]; then
#    NAME_APP="Microsoft Word";
#    PROCESS="Microsoft Word";
    sh ~/restart_word.sh
    exit 0
elif [[ "$_input" == "code" || "$_input" == "vs" ]]; then
#    NAME_APP="Visual Studio Code";
#    PROCESS="Code";# not detected
    sh restart_vscode.sh
    exit 0
else
    echo "Unsupported application: $_input"
    exit 1
fi

# Set the path of the app
APP_PATH="/Applications/$NAME_APP.app"
echo "We open or reopen $NAME_APP placed on $APP_PATH\n"

# Function to check if the application is running
is_app_running() {
    pgrep -x -i "$PROCESS" > /dev/null
}

# Function to restart the application
restart_app() {
    echo "Restarting $NAME_APP..."
    pkill -x -i "$PROCESS"
    sleep "$interval"
    open "$APP_PATH"
}

# Check if the application is running
if is_app_running; then
    # If the application is running, restart it
    restart_app
    echo "$NAME_APP restarted successfully."
else
    # If the application is not running, start it
    echo "$NAME_APP is not running. Starting it..."
    open "$APP_PATH" &
    if is_app_running; then
        echo "$NAME_APP started successfully."
    else
        echo "Failed to restart $NAME_APP."
    fi
fi

