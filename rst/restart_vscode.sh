NAME_APP="Visual Studio Code"
APP_PATH="/Applications/$NAME_APP.app"
interval="10";

echo "Restarting $NAME_APP..."

osascript -e 'quit app "Visual Studio Code"'
sleep "$interval"
open "$APP_PATH"
