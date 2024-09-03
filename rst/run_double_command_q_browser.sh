#!/bin/bash

# Check if a browser name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <BrowserName>"
  exit 1
fi

BROWSER_NAME=$1

osascript ~/auto/rst/DoubleCommandQBrowser.scpt "$BROWSER_NAME"
