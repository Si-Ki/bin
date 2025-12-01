#!/usr/bin/env bash

is_video() {
    # Playerctl metadata
    mime=$(playerctl metadata xesam:contentType 2>/dev/null)
    url=$(playerctl metadata xesam:url 2>/dev/null)
    video=$(playerctl metadata xesam:video 2>/dev/null)
    title=$(playerctl metadata xesam:title 2>/dev/null | tr '[:upper:]' '[:lower:]')

    if [[ "$video" == "true" ]]; then return 0; fi
    if [[ "$mime" == video/* ]]; then return 0; fi
    if [[ "$url" == *"watch?v="* && "$url" != *"music.youtube.com"* ]]; then return 0; fi

    if [[ "$title" == *"youtube music"* ]]; then return 1; fi

    return 1
}

while read -r status; do
    if [[ "$status" == "Playing" ]]; then
        if is_video; then
            systemctl --user stop wluma.service
        else
            systemctl --user start wluma.service
        fi
    else
        systemctl --user start wluma.service
    fi
done < <(playerctl --follow status)
