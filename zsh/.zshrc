source ~/dotfiles/machines/common/zsh/settings.sh
source ~/dotfiles/machines/common/zsh/env.sh
source ~/dotfiles/machines/common/zsh/alias.sh

if [[ "$(uname)" == "Darwin" ]]; then
  source ~/dotfiles/machines/macbookair/zsh/env.sh
  source ~/dotfiles/machines/macbookair/zsh/alias.sh
fi

if [[ "$(uname)" != "Darwin" ]]; then
  source ~/dotfiles/machines/arch/zsh/env.sh
  source ~/dotfiles/machines/arch/zsh/alias.sh
fi

# altlast scheiß, muss noch
alias netcup='ssh hosting178047@ae89a.netcup.net'
alias vd='ssh vd@192.168.22.10'
alias vdproxy='ssh -J simon@lowboy -p 2222 vd@localhost'

alias horbvpn='sudo openvpn --config ~/Documents/clientmac-lehre.ovpn.txt'
alias jltunnel='ssh -f -N -L 9999:localhost:9999 vd@192.168.22.10'

eval "$(starship init zsh)"
