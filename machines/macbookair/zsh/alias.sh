alias p='pbpaste'
alias c='pbcopy'

alias java8='/Users/simon/.sdkman/candidates/java/8.0.412-zulu/bin/java'
alias java21='/opt/homebrew/Cellar/openjdk@21/21.0.5/bin/java'

alias mvn8='export JAVA_HOME=/Users/simon/.sdkman/candidates/java/8.0.412-zulu && mvn'
alias mvn17='export JAVA_HOME=/opt/homebrew/opt/openjdk@17 && export PATH=$JAVA_HOME/bin:$PATH && mvn'
alias mvn21='export JAVA_HOME=/opt/homebrew/Cellar/openjdk@21/21.0.5 && export PATH=$JAVA_HOME/bin:$PATH && mvn'

alias jl='~/dev/jupyter_uv_env/.venv/bin/python -m jupyter lab --notebook-dir= ~/Vorlesungen/NLP/Notebooks'

alias netcupfiles='cd /Users/simon/Library/Containers/net.langui.FTPMounterLite/Data/.FTPVolumes/Netcup' # this only works with FTPMounterLite connected to the netcup server

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Created by `pipx` on 2024-09-11 10:34:37
export PATH="$PATH:/Users/simon/.local/bin"

source ~/dev/hideme_util/hideme.sh
