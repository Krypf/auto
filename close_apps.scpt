# Desktop "Live Clock", "Mini Calendar", "iCollections", "Weather Widget"
# Background "RunCat", "TG Pro", "Karabiner-Elements", "TabLauncher Lite",
# no "BetterTouchTool", "AltTab", "Copyless 2", "Karabiner-Elements", 

set app_list to {"Live Clock", "Mini Calendar", "iCollections", "RunCat", "TG Pro", "TabLauncher Lite", "Weather Widget"}

# tell application "" to quit

repeat with each in app_list
    quit app each
end repeat
