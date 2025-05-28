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

