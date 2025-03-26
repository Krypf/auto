#!/bin/zsh

cd $HOME/auto

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: sh ~/auto/rst/restart_browser.sh <config_file>"
    exit 1
fi

# Load the specified environment variables file
CONFIG_FILE="config/$1.env"

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Error: Config file '$CONFIG_FILE' not found!"
    exit 1
fi

# Function to check if the application is running
is_app_running() {
    pgrep -x -i "$NAME_APP" > /dev/null
}

# If the application is running, execute the termination script
if is_app_running; then
    echo "Closing $NAME_APP..."

    # Execute the application termination script (AppleScript or shell script)
    if [[ "$CLOSE_SCRIPT" == *.scpt ]]; then
        osascript "$CLOSE_SCRIPT" "$NAME_APP"
    else
        sh "$CLOSE_SCRIPT" "$NAME_APP"
    fi

    sleep "$interval"
    echo "Waiting $interval seconds..."

    # Wait until the application stops completely
    while is_app_running; do
        echo "$NAME_APP will restart after $second_interval seconds..."
        sleep "$second_interval"
    done

    # Restart the application
    if ! is_app_running; then
        echo "Rebooting $NAME_APP..."
        open "$APP_PATH"
        sleep 1
        if is_app_running; then
            echo "$NAME_APP restarted successfully."
        else
            echo "Failed to restart $NAME_APP."
        fi
    fi
else
    echo "$NAME_APP is not active."
fi
