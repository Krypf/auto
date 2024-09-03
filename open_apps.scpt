# Desktop "Live Clock", "Mini Calendar", "iCollections",
# Background "RunCat", "TG Pro", "TabLauncher Lite", "BetterTouchTool", "AltTab", "Copyless 2", 
# does not open "Karabiner-Elements", "Unshaky"

set app_list to {"Live Clock", "Mini Calendar", "iCollections", "RunCat", "TG Pro", "TabLauncher Lite", "BetterTouchTool", "AltTab", "Copyless 2"}

# cd /Applications
# set filePath to "/Applications"

repeat with each in app_list
    tell application each to launch
end repeat
# the open is a shell command

