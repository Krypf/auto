#!/usr/bin/zsh

# Define the list of categories
categories=(hep-th gr-qc math-ph quant-ph hep-ph astro-ph cond-mat)

# Iterate over the categories and open each one in a new tab/window
for category in "${categories[@]}"; do
    open "https://arxiv.org/list/$category/new"
done
