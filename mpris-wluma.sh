#!/usr/bin/env bash
# Requires: playerctl, systemctl --user
set -eu

# Function to stop/start wluma
start_wluma() {
  systemctl --user start wluma.service || true
}
stop_wluma() {
  systemctl --user stop wluma.service || true
}

# If playerctl not found, exit
if ! command -v playerctl >/dev/null 2>&1; then
  echo "playerctl not found; please install playerctl or use the dbus-monitor fallback."
  exit 1
fi

# Do an initial check
status=$(playerctl status 2>/dev/null || echo "")
if [[ "$status" == "Playing" ]]; then
  stop_wluma
else
  start_wluma
fi

# Follow playback state changes and react
# playerctl --follow status prints lines like "Playing", "Paused", etc.
playerctl --follow status | while IFS= read -r line; do
  case "$line" in
    Playing)
      echo "Detected Playing -> stopping wluma"
      stop_wluma
      ;;
    Paused|Stopped)
      echo "Detected Paused/Stopped -> starting wluma"
      start_wluma
      ;;
    *)
      echo "playerctl event: $line"
      ;;
  esac
done

