#!/bin/sh
xrandr --output HDMI-1 --primary --mode 1680x1050 --pos 0x0 --rotate normal --output DP-1 --mode 1366x768 --pos 0x1050 --rotate normal

nitrogen --restore
