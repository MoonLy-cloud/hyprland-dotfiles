#!/bin/bash

# Get CPU frequency in MHz
cpu_freq=$(cat /proc/cpuinfo | grep "cpu MHz" | head -1 | awk '{print $4}')

# Convert to GHz and format
if [ -n "$cpu_freq" ]; then
    cpu_ghz=$(awk "BEGIN {printf \"%.2f\", $cpu_freq / 1000}")
    echo "{\"text\":\"${cpu_ghz}GHz\"}"
else
    echo "{\"text\":\"N/A\"}"
fi