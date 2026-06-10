#!/bin/zsh
# https://claude.ai/share/42976be8-8ee8-4547-8bb6-989dbf79e862
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