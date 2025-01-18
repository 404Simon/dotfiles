# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="$PATH:/Users/simon/.dotnet/tools"

ZSH_THEME="powerlevel10k/powerlevel10k"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  tmux
  direnv
)

source $ZSH/oh-my-zsh.sh


if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export TERM=xterm-256color

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/dev/mdformat/env/bin:$PATH"
eval "$(laravel completion)"


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

if [[ "$(uname)" != "Darwin" ]]; then
  source ~/dotfiles/open.sh
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
alias artisan='php artisan'
jl() {
    # Find all .ipynb files in the current directory
    local notebooks=($(find . -maxdepth 1 -name "*.ipynb"))

    echo "Vim Keybindings: https://pypi.org/project/jupyterlab-vim/"

    # if there is exactly one notebook, open it, else just start jupyter
    if [ ${#notebooks[@]} -eq 1 ]; then
        jupyter lab "$notebooks"
    else
        jupyter lab
    fi
}

# alias to use ollama with mods and a tmux popup
alias llm='~/dotfiles/llama.sh'

# i use atac as an api client like postman or insomnia, i need to declare the keybindings in an env var to use vim bindings
export ATAC_KEY_BINDINGS="/Users/simon/dev/atac/keybindings.toml"
export SAM_CLI_TELEMETRY=0

export OBSIDIAN_VAULT="/Users/simon/Library/Mobile Documents/iCloud~md~obsidian/Documents/SimonsVault"

alias fvim='result=$(rg --files --hidden --glob "!.git/**" --glob "!.obsidian/**" | fzf --preview="bat --color=always {}") && [ -n "$result" ] && nvim "$result"'
alias fcode='result=$(fzf --preview="bat --color=always {}") && [ -n "$result" ] && code "$result"'
alias fzf='fzf --tmux 80%,80%'

alias dev='eval "$(~/dotfiles/projectnavigator.sh)"'
alias v='eval "$(~/dotfiles/vorlesungsnavigator.sh)"'
alias o='source ~/dotfiles/obsidian_scripts.sh'
alias trans='~/dotfiles/translate.sh'
alias blog='~/dev/quartz/automation.sh'

alias p='pbpaste'
alias c='pbcopy'

alias java8='/Users/simon/.sdkman/candidates/java/8.0.412-zulu/bin/java'
alias java17='/opt/homebrew/opt/openjdk@17/bin/java'
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

# Function to switch to light mode
function switch_to_light_mode() {
    # Set terminal background and foreground colors
    echo -e "\033]10;#000000\007" # Black text (adjust as needed)
    echo -e "\033]11;#ffffff\007" # White background (adjust as needed)
    echo -e "\033]12;#000000\007" # Black cursor (ensure visibility)

    # Set a specific prompt for light mode
    export PS1="%F{black}%n@%m%f:%F{blue}%~%f$ "

    # Set other Zsh options for light mode
    export LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx" # Set light LS_COLORS
    # Source the new configuration
    source ~/.zshrc
    echo "😡"
}

# Function to switch to dark mode
function switch_to_dark_mode() {
    # Set terminal background and foreground colors
    echo -e "\033]10;#dbdbdb\007" # Light gray text
    echo -e "\033]11;#15191e\007" # Dark gray background
    echo -e "\033]12;#dbdbdb\007" # Light gray cursor (ensure visibility)

    # Set a specific prompt for dark mode
    export PS1="%F{lightgray}%n@%m%f:%F{cyan}%~%f$ "

    # Set other Zsh options for dark mode
    export LSCOLORS="gxfxcxdxbxegedabagacad" # Set dark LS_COLORS

    # Source the new configuration
    source ~/.zshrc
}

export PATH="$HOME/.cargo/bin:$PATH"

# Aliases for easy switching
alias light='switch_to_light_mode'
alias dark='switch_to_dark_mode'

alias ls='eza --color=always --icons=always'
eval $(thefuck --alias)
eval $(thefuck --alias fk)
eval "$(zoxide init zsh)"
alias cd='z'

function weather() {
    location="${*:-Dombühl}"
    location="${location// /+}"
    ~/dev/cli_cacher/cli-cache ~/dev/cli_cacher/cache/ curl -s "wttr.in/$location" | sed '1d;$d;$d'
}

alias fif='bash ~/dotfiles/fif.sh'

source ~/dev/cash/cash.sh
source ~/dev/hideme_util/hideme.sh
alias restarthide='bash ~/dev/hideme_util/restart.sh'

alias ccurl='~/dev/cli_cacher/cli-cache ~/dev/cli_cacher/cache/ curl'
alias chtsh='~/dev/chtsh/cht.sh'

# GraalVM stuff
export JAVA_HOME=/Users/simon/graalvm-jdk-21.0.5+9.1/Contents/Home
export GRAALVM_HOME=/Users/simon/graalvm-jdk-21.0.5+9.1/Contents/Home
export PATH=/Users/simon/graalvm-jdk-21.0.5+9.1/Contents/Home/bin:$PATH


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Created by `pipx` on 2024-09-11 10:34:37
export PATH="$PATH:/Users/simon/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
