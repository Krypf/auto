NAME_APP="Firefox";
APP_PATH="/Applications/$NAME_APP.app";
interval="15";
second_interval="35";

# Function to check if the application is running
is_app_running() {
    pgrep -x -i "$NAME_APP" > /dev/null
}

# Check if the application is running
if is_app_running; then
    # Execute Firefox_Option_Command_Q_Enter.scpt
    osascript ~/auto/rst/Option_Command_Q_Enter.scpt $NAME_APP
	sleep "$interval"
	echo "sleep $interval seconds..."
	while is_app_running; do
		# If the application is still running, wait $second_interval seconds
		echo "$NAME_APP will restart after $second_interval seconds..."
		sleep "$second_interval"
	done
	if ! is_app_running; then
		echo "reboot"
		open "$APP_PATH"
		sleep "1"
		if is_app_running; then
		echo "$NAME_APP restarted successfully."
		fi
	fi
else
	echo "$NAME_APP is not active."
fi
