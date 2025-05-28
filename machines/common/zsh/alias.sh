alias work="timer 25m && terminal-notifier -message 'Santa 🎅🏼'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

alias chill="timer 7m && terminal-notifier -message 'Santa 🎅🏼'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

alias vim='nvim'
alias t='tmux a || tmux'
alias y='yazi'
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

