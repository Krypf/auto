NAME_APP="Firefox";
APP_PATH="/Applications/$NAME_APP.app";
interval="10";
second_interval="40";

# Function to check if the application is running
is_app_running() {
    pgrep -x -i "$NAME_APP" > /dev/null
}

# Check if the application is running
if is_app_running; then
    # Execute Firefox_Option_Command_Q_Enter.scpt
    osascript ~/auto/rst/Firefox_Option_Command_Q_Enter.scpt
	sleep "$interval"
	echo "sleep $interval seconds..."
	if is_app_running; then
		# If the application is still running, wait $second_interval minutes
		echo "$NAME_APP will restart after $second_interval seconds..."
		sleep "$second_interval"
		echo "reboot"
	fi
	open "$APP_PATH"
	echo "$NAME_APP restarted successfully."
fi
