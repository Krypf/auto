-- https://chatgpt.com/share/c18650d4-2bb1-4336-b333-8d0aaa598d25
-- This script activates one application (Firefox, BetterTouchTool), sends the shortcut Option + Command + Q to close all windows or quit the app, waits for a second, and then presses Enter to confirm the action.

on run argv
    set appName to item 1 of argv

    tell application appName to activate
    delay 0.3 -- Wait for activation

    tell application "System Events"
        -- Send Option + Command + Q
        keystroke "q" using {option down, command down}

        -- Wait for a short moment (e.g., 1 second) to ensure the confirmation dialog appears
        delay 1

        -- Press Enter to confirm (if a dialog appears)
        key code 36 -- Enter key
    end tell
end run