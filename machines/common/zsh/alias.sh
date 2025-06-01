alias vim='nvim'
alias t='tmux a || tmux'
alias y='yazi'
alias fzf='fzf --tmux 80%,80%'
alias artisan='php artisan'
alias dev='eval "$(~/dotfiles/projectnavigator.sh)"'
alias v='eval "$(~/dotfiles/vorlesungsnavigator.sh)"'
alias o='source ~/dotfiles/obsidian_scripts.sh'
alias art='~/dotfiles/art'
alias trans='~/dotfiles/translate.sh'
alias blog='~/dev/quartz/automation.sh'

alias ls='eza --color=always --icons=always'
eval $(thefuck --alias)
eval $(thefuck --alias fk)
eval "$(zoxide init zsh)"
alias cd='z'

function weather() {
    location="${*:-Dombühl}"
    location="${location// /+}"
    curl -s "wttr.in/$location" | sed '1d;$d;$d'
}

alias arkserver="ssh -p 8888 lux"

# -- Pomodoro --
icon=~/Pictures/pumpkin.png

# IMPORTANT: mpv MUST be started with an IPC server for this to work.
# Example: mpv --input-ipc-server=/tmp/mpv-socket /path/to/your/audio.mp3 &
MPV_IPC_SOCKET="/tmp/mpv-socket"

mpv_send_command() {
  local command_json="$1"
  if command -v socat >/dev/null; then
    if pgrep mpv >/dev/null; then # Check if an mpv process is running
      if [[ -S "$MPV_IPC_SOCKET" ]]; then # Check if the socket file exists and is a socket
        echo "$command_json" | socat - "$MPV_IPC_SOCKET" 2>/dev/null
      fi
    fi
  else
    echo "Error: 'socat' not found. Cannot control mpv via IPC." >&2
  fi
}

if [[ $(uname) == Darwin ]] && command -v terminal-notifier >/dev/null; then
  notify(){ terminal-notifier \
              -title "$1" \
              -message "$2" \
              -appIcon "$icon" \
              -sound Crystal; }
else
  notify(){ notify-send -i "$icon" "$1" "$2";paplay /usr/share/sounds/freedesktop/stereo/complete.oga;paplay /usr/share/sounds/freedesktop/stereo/complete.oga; }
fi

work(){
        mpv_send_command '{ "command": ["set_property", "pause", false] }'
        timer ${1:-25}m && \
        mpv_send_command '{ "command": ["set_property", "pause", true] }'
        notify "Work Timer is up! Take a Break 😊" "Santa 🎅🏼" && \
}

chill(){ timer ${1:-7}m && \
         notify "Break is over! Get back to work 😬" "Santa 🎅🏼"; }
# -- End Pomodoro --
