#!/bin/bash

APP=$(echo "$WAYBAR_OUTPUT" | sed -n "s/.*data-cmd='\([^']*\)'.*/\1/p")

if [ -z "$APP" ]; then
  exit 0
fi

if [ "$WAYBAR_SHIFT" = "true" ]; then
  "$APP" &
  exit 0
fi

