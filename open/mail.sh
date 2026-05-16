#!/bin/zsh
# Add or remove apps from the list below

apps=(
  "Mail"
  "Spark Desktop"
  "Microsoft Outlook"
  "Slack"
  "LINE"
)

# Directories to search for apps
search_dirs=(
  "/Applications"
  "/System/Applications"
  "/System/Applications/Utilities"
)

for app in "${apps[@]}"; do
  app_path=""
  for dir in "${search_dirs[@]}"; do
    if [[ -d "${dir}/${app}.app" ]]; then
      app_path="${dir}/${app}.app"
      break
    fi
  done

  if [[ -z "$app_path" ]]; then
    echo "Error: '$app' not found"
    continue
  fi

  if open "$app_path" 2>/dev/null; then
    echo "Opened: $app ($app_path)"
  else
    echo "Error: '$app' could not be launched"
  fi
done