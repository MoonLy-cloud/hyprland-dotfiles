#!/bin/bash

# Get current GPU information
gpu_info=$(lspci | grep -i vga | head -1 | cut -d: -f3 | sed 's/^ *//')

if [ -z "$gpu_info" ]; then
    gpu_info=$(lspci | grep -i "3d controller" | head -1 | cut -d: -f3 | sed 's/^ *//')
fi

# Clean up the GPU name (remove unnecessary parts)
gpu_name=$(echo "$gpu_info" | sed 's/Corporation //g' | sed 's/Technologies Inc //g' | sed 's/\[.*\]//g' | sed 's/^ *//g' | sed 's/ *$//g')

# Output for waybar
echo "$gpu_name"