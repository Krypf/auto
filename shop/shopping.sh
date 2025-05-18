#!/bin/zsh

cd $HOME/auto

KEYWORDS="$1"

if [[ -z $KEYWORDS ]]; then
    echo "Usage: $0 <search_query>"
    exit 1
fi

source shop/shop.env

query=$(echo $KEYWORDS | jq -sRr @uri)  # encode URL
urls=(
    "https://www.biccamera.com/bc/main"
    "https://www.yodobashi.com/?word=${query}"
    "https://www.amazon.co.jp/s?k=${query}"
    "${YAHOO_BASE_URL}${query}"
)

for url in "${urls[@]}"; do
    open "$url"
done

echo "Search completed for: $KEYWORDS"
echo "$KEYWORDS" | pbcopy
echo "Copied: $KEYWORDS"
