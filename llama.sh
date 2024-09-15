function inputwindow() {
    tmux popup -E 'gum write --height 22 > ~/.llm-prompt'
}

option=$(gum choose "New" "Continue Last" "Show Last" "Continue Specific" "Browse" "Copy" )

if [ "$option" == "New" ]; then
    inputwindow
    input=$(<~/.llm-prompt)
    if [ -z "$input" ]; then
        exit 0
    fi
    mods "$input"
elif [ "$option" == "Continue Last" ]; then
    inputwindow
    input=$(<~/.llm-prompt)
    if [ -z "$input" ]; then
        exit 0
    fi
    mods --continue-last "$input"
elif [ "$option" == "Browse" ]; then
    mods --list
    mods -s $(pbpaste)
elif [ "$option" == "Show Last" ]; then
    mods -S
elif [ "$option" == "Continue Specific" ]; then
    mods --list
    inputwindow
    input=$(<~/.llm-prompt)
    if [ -z "$input" ]; then
        exit 0
    fi
    mods --continue $(pbpaste) "$input"
elif [ "$option" == "Copy" ]; then
    mods --list
    mods -r -s $(pbpaste) | pbcopy
fi
