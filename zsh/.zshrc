source ~/dotfiles/machines/common/zsh/settings.sh
source ~/dotfiles/machines/common/zsh/env.sh
source ~/dotfiles/machines/common/zsh/alias.sh

if [[ "$(uname)" == "Darwin" ]]; then
  source ~/dotfiles/machines/macbookair/zsh/env.sh
  source ~/dotfiles/machines/macbookair/zsh/alias.sh
else
  source ~/dotfiles/machines/arch/zsh/env.sh
  source ~/dotfiles/machines/arch/zsh/alias.sh
fi

eval "$(starship init zsh)"
