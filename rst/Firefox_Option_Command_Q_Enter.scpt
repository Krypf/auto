-- https://chatgpt.com/share/c18650d4-2bb1-4336-b333-8d0aaa598d25
-- Firefox をアクティブにする
tell application "Firefox" to activate
delay 0.3

tell application "System Events"
    -- Option+Command+Qを送信
    keystroke "q" using {option down, command down}
    
    -- 少し間をおく（例えば、1秒）
    delay 1
    
    -- Enterキーを押す
    key code 36 -- Enterキーのkey codeは36
end tell

