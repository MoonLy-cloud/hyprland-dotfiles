#!/bin/bash

# Get current GPU mode from envycontrol
mode=$(envycontrol --query 2>/dev/null)

# Función para detectar y mostrar la iGPU
show_igpu() {
    igpu_info=$(lspci | grep -i 'vga\|3d\|display' | grep -i 'amd\|intel')
    if echo "$igpu_info" | grep -iq 'amd'; then
        # Buscar U o G en el modelo
        if echo "$igpu_info" | grep -Eq 'U|G'; then
            echo '{"text": "AMD", "class": "amd-red", "tooltip": "GPU: AMD iGPU"}'
        else
            echo '{"text": "AMD", "class": "amd", "tooltip": "GPU: AMD iGPU"}'
        fi
    elif echo "$igpu_info" | grep -iq 'intel'; then
        echo '{"text": "Intel", "class": "intel", "tooltip": "GPU: Intel iGPU"}'
    else
        echo '{"text": "iGPU", "class": "integrated", "tooltip": "GPU: Integrated mode"}'
    fi
}

case "$mode" in
    *"nvidia"*)
        echo '{"text": "NVIDIA", "class": "nvidia", "tooltip": "GPU: NVIDIA mode"}'
        ;;
    *"integrated"*)
        show_igpu
        ;;
    *"hybrid"*)
        show_igpu
        ;;
    *)
        echo '{"text": "Unknown", "class": "unknown", "tooltip": "GPU: Status unknown"}'
        ;;
esac