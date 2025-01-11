#!/bin/zsh


if [ "$OBSIDIAN_VAULT" != "$(pwd)" ]; then
    lastloc=$(pwd)
fi

function back() {
    cd $lastloc
}

function obsidiancd() {
    cd $OBSIDIAN_VAULT
}

function obsidianglow() {
    cd $OBSIDIAN_VAULT
    glow -s "tokyo-night"
    back
}

function obsidianfvim() {
    cd /Users/simon/Library/Mobile Documents/iCloud~md~obsidian/Documents/SimonsVault
    result=$(rg --files --hidden --glob "!.git/**" --glob "!.obsidian/**" | fzf --preview="bat --color=always {}") && [ -n "$result" ] && nvim "$result"
}

function obsidianjournal() {
    cd "$OBSIDIAN_VAULT/Journal"
    glow
    back
}

function obsidiandaily() {
    ~/dotfiles/create_daily_note.sh
    TODAY=$(date +"%Y-%m-%d")
    FILE_PATH="$OBSIDIAN_VAULT/Journal/$TODAY.md"
    nvim +5 "$FILE_PATH"
}

function obsidianyesterday() {
    YESTERDAY=$(date -v-1d +"%Y-%m-%d")
    FILE_PATH="$OBSIDIAN_VAULT/Journal/$YESTERDAY.md"
    if [ -f "$FILE_PATH" ]; then
        nvim +5 "$FILE_PATH"
    else
        echo "No note for yesterday"
    fi
}

function obsidianscript() {
    nvim ~/dotfiles/obsidian_scripts.sh
}

function obsidiannew() {
    cd "$OBSIDIAN_VAULT"
    result=$(~/dotfiles/create_new_note.sh)
    if [[ $result == *.md ]]; then
        nvim +8 "$result"
    else
        echo "No file created"
    fi
}

function obsidianappend() {
    ~/dotfiles/create_daily_note.sh > /dev/null
    TODAY=$(date +"%Y-%m-%d")
    FILE_PATH="$OBSIDIAN_VAULT/Journal/$TODAY.md"
    text=$(gum write --placeholder "Dont forget to...")
    if [ ! -z "$text" ]; then
        echo "Saving..."
        echo -e "\n$text" >> "$FILE_PATH"
    fi
}

function obsidiansetup() {
    ~/dotfiles/shell_harpoon/setup_shell_harpoon.sh
}

function obsidianharpoon() {
    harpooned=$(cat ~/.shell_harpoon)
    if [ ! -z "$harpooned" ]; then
        nvim +3 "$harpooned"
    else
        echo "No file harpooned"
    fi
}

function obsidianrecent() {
    cd "$OBSIDIAN_VAULT"
    file=$(find . -type d \( -name .git -o -name .obsidian \) -prune -o -type f -exec stat -f '%m %N' {} + | \
    sort -n -r | \
    head -n 20 | \
    cut -d' ' -f2- | \
    fzf --preview 'bat --color=always {}')
    if [ ! -z "$file" ]; then
        nvim "$file"
    fi
}

function obsidiangrep() {
    cd "$OBSIDIAN_VAULT"
    nvim -c "lua require('telescope.builtin').live_grep()"
}

cmds=(
    'cd - cd to your vault'
    'glow - Glow your vault'
    'fvim - search n edit'
    'journal - Admire your journal'
    'daily - Open your daily note'
    'yesterday - Open yesterdays daily note'
    'script - Modify this script'
    'new - Create a new note'
    'append - append to your daily note'
    'setup - setup shooting device'
    'harpoon - open harpooned file'
    'recent - open recent file'
    'grep - grep over all files'
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

