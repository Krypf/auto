-- General AppleScript for pressing Command + Q twice in any browser
on run {browserName}
    -- activate the browser
    tell application browserName to activate
    delay 0.5
    tell application "System Events"
        -- Command + Q を2回送信
        key down command
        keystroke "q"
        delay 0.1
        keystroke "q"
        key up command
    end tell
end run
