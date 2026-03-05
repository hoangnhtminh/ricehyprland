#!/usr/bin/env python3
"""Waybar mediaplayer script — shows currently playing track."""
import sys
import subprocess
import json

def get_status():
    try:
        player = subprocess.check_output(
            ["playerctl", "--player=spotify,firefox,%any", "status"],
            stderr=subprocess.DEVNULL
        ).decode().strip()
    except subprocess.CalledProcessError:
        return None, None

    try:
        title = subprocess.check_output(
            ["playerctl", "--player=spotify,firefox,%any", "metadata", "--format",
             "{{trunc(title,25)}} — {{trunc(artist,20)}}"],
            stderr=subprocess.DEVNULL
        ).decode().strip()
    except subprocess.CalledProcessError:
        title = ""

    try:
        player_name = subprocess.check_output(
            ["playerctl", "--player=spotify,firefox,%any", "metadata", "--format", "{{playerName}}"],
            stderr=subprocess.DEVNULL
        ).decode().strip()
    except subprocess.CalledProcessError:
        player_name = "default"

    return player, title, player_name


result = get_status()
if result is None or result[0] is None:
    sys.exit(0)

status, title, player_name = result

if status == "Playing" and title:
    output = {
        "text": title,
        "alt": player_name,
        "tooltip": f"{player_name.capitalize()} — {title}",
        "class": player_name
    }
    print(json.dumps(output))
