#!/usr/bin/env bash

set -euo pipefail

URL="${1:-}"

DEFAULT_STRIP_TAGS="script,style,noscript,iframe,object,embed"

get_site_type() {
    local url="$1"

    if [[ "$url" =~ (youtube\.com|youtu\.be) ]]; then
        echo "youtube"
    elif [[ "$url" =~ tagesschau\.de ]]; then
        echo "tagesschau"
    else
        echo "generic"
    fi
}

process_youtube() {
    local url="$1"
    echo "Opening YouTube URL with mpv in background..."
    nohup mpv \
        --hwdec=auto \
        --vo=gpu \
        --force-window=immediate \
        --cache=yes \
        --cache-secs=10 \
        --demuxer-max-bytes=200M \
        --demuxer-max-back-bytes=100M \
        --demuxer-readahead-secs=20 \
        --video-sync=audio \
        --framedrop=vo \
        --audio-buffer=10.0 \
        --audio-samplerate=48000 \
        --audio-channels=stereo \
        --af=scaletempo2 \
        "$url" > /dev/null 2>&1 &
    exit 0
}

process_tagesschau() {
    local url="$1"
    local tmp_md="$2"
    
    echo "Processing Tagesschau article..."
    
    html-to-markdown \
        --url "$url" \
        --preprocess \
        --preset aggressive \
        --strip-tags "$DEFAULT_STRIP_TAGS" \
        > "$tmp_md"
    
    sed -i '/^## Mehr zum Thema$/,$d' "$tmp_md"
    sed -i '/^## Mehr von/,$d' "$tmp_md"
    sed -i '
        /^---$/,/^---$/d
        
        # remove navlinks (lines starting with -)
        /^- \[.*\](#.*".*")/d
        
        # remove image alt text descriptions in parentheses
        s/| [^)]*dpa[^)]*)/)/g
        s/| [^)]*AFP[^)]*)/)/g
        s/| [^)]*REUTERS[^)]*)/)/g
        s/| [^)]*ARD[^)]*)/)/g
        
        # remove standalone image links
        /^!\[.*\](http.*width=256$/d
        
        # remove "Zur Startseite" and footer content
        /^\[Zur Startseite/,$d
        
        # remove "Dieses Thema im Programm" line
        /^Dieses Thema im Programm:/d
    ' "$tmp_md"
    
    sed -i '
        # Remove trailing whitespace
        s/[[:space:]]*$//
        
        # Remove multiple consecutive blank lines
        /^$/{ N; /^\n$/D; }
    ' "$tmp_md"
}

process_generic() {
    local url="$1"
    local tmp_md="$2"
    
    html-to-markdown \
        --url "$url" \
        --preprocess \
        --preset aggressive \
        --strip-tags "$DEFAULT_STRIP_TAGS" \
        --extract-metadata \
        --code-block-style backticks \
        --wrap \
        --wrap-width 100 \
        > "$tmp_md"
}

main() {
    if [[ -z "$URL" ]]; then
        echo "Usage: $0 <url>"
        exit 1
    fi
    
    site_type=$(get_site_type "$URL")
    
    if [[ "$site_type" == "youtube" ]]; then
        process_youtube "$URL"
        exit 0
    fi
    
    tmp_md=$(mktemp /tmp/open-web-md.XXXXXX.md)
    trap "rm -f '$tmp_md'" EXIT
    
    case "$site_type" in
        tagesschau)
            process_tagesschau "$URL" "$tmp_md"
            ;;
        generic|*)
            process_generic "$URL" "$tmp_md"
            ;;
    esac
    
    nvim "$tmp_md"
}

main
