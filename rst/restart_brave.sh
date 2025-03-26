NAME_APP="Brave Browser";
APP_PATH="/Applications/$NAME_APP.app";
interval="10";

# Function to check if the application is running
is_app_running() {
    pgrep -x -i "$NAME_APP" > /dev/null
}

# Check if the application is running
if is_app_running; then
	sh ~/auto/rst/run_double_command_q_browser.sh "$NAME_APP"
	sleep "$interval"
	echo "sleep $interval seconds..."
	while is_app_running; do
		# If the application is still running, wait $interval seconds
		echo "$NAME_APP will restart after $interval seconds..."
		sleep "$interval"
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
