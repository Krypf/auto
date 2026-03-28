#!/bin/zsh

# Check if an argument was provided
if [[ -z "$1" ]]; then
    echo "Usage: restart <AppName>"
    echo "Example: restart \"Visual Studio Code\""
    return 1 2>/dev/null || exit 1
fi

NAME_APP="$1"
APP_PATH="/Applications/${NAME_APP}.app"
interval=5

# Verify the app exists in the Applications folder
if [[ ! -d "$APP_PATH" ]]; then
    echo "Error: Could not find '$NAME_APP' in /Applications."
    return 1 2>/dev/null || exit 1
fi

echo "Restarting $NAME_APP..."

# Attempt a graceful quit
osascript -e "quit app \"$NAME_APP\""

# Wait for the app to close
sleep $interval

# Reopen the app
open "$APP_PATH"

echo "Successfully restarted $NAME_APP."