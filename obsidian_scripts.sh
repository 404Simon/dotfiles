#!/bin/zsh


vaultpath="/Users/simon/Library/Mobile Documents/iCloud~md~obsidian/Documents/SimonsVault"

if [ "$vaultpath" != "$(pwd)" ]; then
    lastloc=$(pwd)
fi

function back() {
    cd $lastloc
}

function obsidiancd() {
    cd $vaultpath
}

function obsidianglow() {
    cd $vaultpath
    glow
    back
}

function obsidianfvim() {
    cd /Users/simon/Library/Mobile Documents/iCloud~md~obsidian/Documents/SimonsVault
    result=$(rg --files --hidden --glob "!.git/**" --glob "!.obsidian/**" | fzf --preview="bat --color=always {}") && [ -n "$result" ] && nvim "$result"
}

function obsidianjournal() {
    cd "$vaultpath/Journal"
    glow
    back
}

function obsidiandaily() {
    ~/dotfiles/create_daily_note.sh
}

function obsidianscript() {
    nvim ~/dotfiles/obsidian_scripts.sh
}

cmds=(
    'cd - cd to your vault'
    'glow - Glow your vault'
    'fvim - search n edit'
    'journal - Admire your journal'
    'daily - Open your daily note'
    'script - Modify this script'
)

selected=$(printf "%s\n" "${cmds[@]}" | fzf --prompt="What do you want to do? :) ")

command=$(echo "$selected" | awk '{print $1}')

if [[ -n "$command" ]]; then
    obsidianCommand="obsidian$command"
    if declare -f "$obsidianCommand" > /dev/null; then
        "$obsidianCommand"
    else
        echo "Function $obsidianCommand not found"
    fi
else
    echo "No option selected"
fi

