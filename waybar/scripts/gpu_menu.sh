#!/bin/bash
notify-send "GPU Stats" "$(nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu,memory.used,memory.total --format=csv)"
