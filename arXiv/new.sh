#!/usr/bin/zsh
# https://chatgpt.com/share/67dc7d32-bd40-800e-b215-db0358aa5e99

# Define the list of categories
categories=(hep-th gr-qc math-ph quant-ph hep-ph astro-ph cond-mat)

# Iterate over the categories and open each one in a new tab/window
for category in "${categories[@]}"; do
    open "https://arxiv.org/list/$category/new"
done
