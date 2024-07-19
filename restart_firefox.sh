NAME_APP="Firefox";
APP_PATH="/Applications/$NAME_APP.app";
interval="10";

# Function to check if the application is running
is_app_running() {
    pgrep -x -i "$NAME_APP" > /dev/null
}

# Check if the application is running
if is_app_running; then
    # Execute Firefox_Option_Command_Q_Enter.scpt
    osascript ~/auto/Firefox_Option_Command_Q_Enter.scpt
	sleep "$interval"
	echo "sleep $interval seconds..."
	if is_app_running; then
		# If the application is still running, wait 30 minutes
		echo "$NAME_APP will restart after 30 seconds..."
		sleep "30"
		echo "reboot"
	fi
	open "$APP_PATH"
	echo "$NAME_APP restarted successfully."
fi
