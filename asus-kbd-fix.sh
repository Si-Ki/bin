#!/bin/bash
# Safer reload that won't break if modules can't be found
modprobe -r asus_wmi asus_nb_wmi 2>/dev/null || true
sleep 2
modprobe asus_nb_wmi || exit 0
modprobe asus_wmi || exit 0
