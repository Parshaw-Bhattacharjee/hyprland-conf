#!/bin/bash

iGPU=$(intel_gpu_top -l 1 2>/dev/null | awk '/Render/ {print int($3)}')
dGPU=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)

echo "{\"text\":\"iGPU ${iGPU:-0}% | dGPU ${dGPU:-0}%\",\"tooltip\":\"Integrated GPU: ${iGPU:-0}%\nNVIDIA GPU: ${dGPU:-0}%\"}"
