# new for setup without p10k or oh my zsh (just starship)
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt share_history
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Za-z} r:|=*' \
  'm:{a-z}={A-Za-z} l:|=* r:|=*'

zstyle ':completion:*' menu select=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# -------------------------------------------------------------
# if the last two chars before the cursor are “..” then
# insert “/” on Tab, else do the usual expand-or-complete
# -------------------------------------------------------------
insert-slash-if-dotdot() {
  # ${LBUFFER: -2} is the last two chars of the left side of the buffer
  if [[ ${LBUFFER: -2} == '..' ]]; then
    LBUFFER+='/'
  else
    zle expand-or-complete
  fi
}

# create a zle widget and bind it to Tab (Ctrl-I)
zle -N insert-slash-if-dotdot
bindkey '^I' insert-slash-if-dotdot

# other stuff


export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux"


if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export TERM=xterm-256color

export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/dev/mdformat/env/bin:$PATH"
export PATH="/home/simon/.local/bin:$PATH"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
eval $(laravel completion)


# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

export BAT_THEME=tokyonight_night

# there are a bunch of environment vars for gum, so i put them in a file and source it here
source ~/gum_env.sh


if [[ "$(uname)" == "Darwin" ]]; then
source ~/dev/hideme_util/hideme.sh
fi

if [[ "$(uname)" != "Darwin" ]]; then
  source ~/dotfiles/open.sh
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

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
alias artisan='php artisan'
alias jl='~/dev/jupyter_uv_env/.venv/bin/python -m jupyter lab --notebook-dir= ~/Vorlesungen/NLP/Notebooks/'
alias pos='zsh /Users/simon/dotfiles/pos_tags.sh'
alias art='zsh ~/dotfiles/art'

# alias to use ollama with mods and a tmux popup
alias llm='~/dotfiles/llama.sh'

# i use atac as an api client like postman or insomnia, i need to declare the keybindings in an env var to use vim bindings
export ATAC_KEY_BINDINGS="/Users/simon/dev/atac/keybindings.toml"
export SAM_CLI_TELEMETRY=0

export OBSIDIAN_VAULT="/home/simon/obsidian-vault"

alias fvim='result=$(rg --files --hidden --glob "!.git/**" --glob "!.obsidian/**" | fzf --preview="bat --color=always {}") && [ -n "$result" ] && nvim "$result"'
alias fcode='result=$(fzf --preview="bat --color=always {}") && [ -n "$result" ] && code "$result"'
alias fzf='fzf --tmux 80%,80%'

alias dev='eval "$(~/dotfiles/projectnavigator.sh)"'
alias v='eval "$(~/dotfiles/vorlesungsnavigator.sh)"'
alias o='source ~/dotfiles/obsidian_scripts.sh'
alias art='~/dotfiles/art'
alias trans='~/dotfiles/translate.sh'
alias blog='~/dev/quartz/automation.sh'

alias p='pbpaste'
alias c='pbcopy'

alias java8='/Users/simon/.sdkman/candidates/java/8.0.412-zulu/bin/java'
alias java21='/opt/homebrew/Cellar/openjdk@21/21.0.5/bin/java'

alias mvn8='export JAVA_HOME=/Users/simon/.sdkman/candidates/java/8.0.412-zulu && mvn'
alias mvn17='export JAVA_HOME=/opt/homebrew/opt/openjdk@17 && export PATH=$JAVA_HOME/bin:$PATH && mvn'
alias mvn21='export JAVA_HOME=/opt/homebrew/Cellar/openjdk@21/21.0.5 && export PATH=$JAVA_HOME/bin:$PATH && mvn'

alias lux='ssh root@194.15.36.188'
alias netcup='ssh hosting178047@ae89a.netcup.net'
alias netcupfiles='cd /Users/simon/Library/Containers/net.langui.FTPMounterLite/Data/.FTPVolumes/Netcup' # this only works with FTPMounterLite connected to the netcup server
alias containerer='ssh simon@192.168.178.91'
alias vd='ssh vd@192.168.22.10'
alias vdproxy='ssh -J simon@lowboy -p 2222 vd@localhost'

alias horbvpn='sudo openvpn --config ~/Documents/clientmac-lehre.ovpn.txt'
alias jltunnel='ssh -f -N -L 9999:localhost:9999 vd@192.168.22.10'

export PATH="$HOME/.cargo/bin:$PATH"


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

alias suspend='systemctl suspend'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Created by `pipx` on 2024-09-11 10:34:37
export PATH="$PATH:/Users/simon/.local/bin"

alias arkserver="ssh -p 8888 lux"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
