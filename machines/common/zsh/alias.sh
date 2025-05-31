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

if [[ $(uname) == Darwin ]] && command -v terminal-notifier >/dev/null; then
  notify(){ terminal-notifier \
              -title "$1" \
              -message "$2" \
              -appIcon "$icon" \
              -sound Crystal; }
else
  notify(){ notify-send -i "$icon" "$1" "$2";paplay /usr/share/sounds/freedesktop/stereo/complete.oga;paplay /usr/share/sounds/freedesktop/stereo/complete.oga; }
fi

work(){ timer ${1:-25m} && \
        notify "Work Timer is up! Take a Break 😊" "Santa 🎅🏼"; }

chill(){ timer ${1:-7m} && \
         notify "Break is over! Get back to work 😬" "Santa 🎅🏼"; }
# -- End Pomodoro --
