#!/bin/sh

conncount=$(xrandr | sed -nE '/^[A-Z]+[0-9]+ connected/p' | wc -l)
if [ "$conncount" -ge 2 ]; then
    xrandr --output HDMI1 --left-of VGA1 --output VGA1 --rotate right
fi
