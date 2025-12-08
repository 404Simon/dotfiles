#!/usr/bin/env bash

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: youtube_channel_id.sh <channel_handle>"
    exit 1
fi

CHANNEL_HANDLE="$1"
if [[ ! "$CHANNEL_HANDLE" =~ ^@ ]]; then
    CHANNEL_HANDLE="@${CHANNEL_HANDLE}"
fi

URL="https://www.youtube.com/${CHANNEL_HANDLE}"
RESPONSE=$(curl -s -L "$URL")

CHANNEL_ID=$(echo "$RESPONSE" | grep -oP '"externalId":"[^"]+' | head -1 | cut -d'"' -f4 || true)

if [ -z "$CHANNEL_ID" ]; then
    # Fall back to channelId if externalId not found
    CHANNEL_ID=$(echo "$RESPONSE" | grep -oP '"channelId":"[^"]+' | head -1 | cut -d'"' -f4 || true)
fi

if [ -z "$CHANNEL_ID" ]; then
    echo "Error: No channel ID found for ${CHANNEL_HANDLE}" >&2
    exit 1
fi

echo "https://www.youtube.com/feeds/videos.xml?channel_id=$CHANNEL_ID #${CHANNEL_HANDLE:1}"
