# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

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


alias vim='nvim'
alias fml='bash ~/dev/fml/fml'

# i use atac as an api client like postman or insomnia, i need to declare the keybindings in an env var to use vim bindings
export ATAC_KEY_BINDINGS="/Users/simon/dev/atac/keybindings.toml"

alias fvim='result=$(fzf --preview="bat --color=always {}") && [ -n "$result" ] && nvim "$result"'
alias fcode='result=$(fzf --preview="bat --color=always {}") && [ -n "$result" ] && code "$result"'
alias fzf='fzf --tmux 80%,80%'

alias dev='cd ~/dev'
alias obsidian='cd /Users/simon/Library/Mobile Documents/iCloud~md~obsidian/Documents/SimonsVault && result=$(rg --files --hidden --glob "!.git/**" --glob "!.obsidian/**" | fzf --preview="bat --color=always {}") && [ -n "$result" ] && nvim "$result"'

alias p='pbpaste'
alias c='pbcopy'

alias java8='/Users/simon/.sdkman/candidates/java/8.0.412-zulu/bin/java'
alias java17='/opt/homebrew/opt/openjdk@17/bin/java'
alias java22='/opt/homebrew/Cellar/openjdk/22.0.1/bin/java'

alias mvn8='export JAVA_HOME=/Users/simon/.sdkman/candidates/java/8.0.412-zulu && mvn'
alias mvn17='export JAVA_HOME=/opt/homebrew/opt/openjdk@17 && export PATH=$JAVA_HOME/bin:$PATH && mvn'
alias mvn22='export JAVA_HOME=/opt/homebrew/Cellar/openjdk/22.0.1 && export PATH=$JAVA_HOME/bin:$PATH && mvn'

alias lux='ssh root@194.15.36.188'
alias netcup='ssh hosting178047@ae89a.netcup.net'
alias netcupfiles='cd /Users/simon/Library/Containers/net.langui.FTPMounterLite/Data/.FTPVolumes/Netcup' # this only works with FTPMounterLite connected to the netcup server
alias containerer='ssh simon@192.168.178.91'

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

source ~/dev/cash/cash.sh
source ~/dev/hideme_util/hideme.sh

alias ccurl='~/dev/cli_cacher/cli-cache ~/dev/cli_cacher/cache/ curl'
alias chtsh='~/dev/chtsh/cht.sh'


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
