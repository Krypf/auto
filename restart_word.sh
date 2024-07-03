NAME_APP="Microsoft Word";
APP_PATH="/Applications/$NAME_APP.app";
interval="2";
# enter the file name
FILE_PATH=$1

echo "Restarting $NAME_APP..."

open "$APP_PATH"
sleep 0.3
osascript "auto/word_save_enter.scpt"

osascript -e 'quit app "Microsoft Word"'

sleep "$interval"
open "$APP_PATH"
open "$FILE_PATH"