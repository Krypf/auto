NAME_APP="Brave Browser";
APP_PATH="/Applications/$NAME_APP.app";
interval="5";

sh ~/auto/run_double_command_q_browser.sh "$NAME_APP"
sleep "$interval"
open "$APP_PATH"