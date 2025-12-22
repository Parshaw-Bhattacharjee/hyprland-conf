#!/bin/bash
grep 'cpu ' /proc/stat | awk '{printf "%.0f\n", ($2+$4)*100/($2+$4+$5)}'
