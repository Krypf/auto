#!/bin/zsh
# Add or remove apps from the list below
apps=(
"Microsoft Outlook"
"Visual Studio Code"
"Zotero"
"Brave Browser"
"Safari"
)

for app in "${apps[@]}"; do
    open -a "$app"
    sleep 3
done