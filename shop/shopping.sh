#!/bin/zsh

if [[ -z "$1" ]]; then
    echo "Usage: $0 <search_query>"
    exit 1
fi

query=$(echo "$1" | jq -sRr @uri)  # encode URL
urls=(
    "https://www.biccamera.com/bc/main"
    "https://www.yodobashi.com/?word=${query}"
    "https://www.amazon.co.jp/s?k=${query}"
)

for url in "${urls[@]}"; do
    open "$url"
done
