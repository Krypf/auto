NAME_APP="Microsoft Word";
APP_PATH="/Applications/$NAME_APP.app";
interval="2";
# enter the file name
FILE_PATH=$1

# error 処理
if [ -z "$LIBRARY_NAME" ]; then
  echo "Usage: $0 <library_name>"
  exit 1
fi

echo "Restarting $NAME_APP..."

open "$APP_PATH"
sleep 0.3
osascript "~/auto/rst/word_save_enter.scpt"

osascript -e 'quit app "Microsoft Word"'

sleep "$interval"
open "$APP_PATH"
open "$FILE_PATH"