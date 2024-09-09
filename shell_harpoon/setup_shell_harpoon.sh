option=$(gum choose new existing --header="Setup Shell Harpoon to new or existing note?")

if [ "$option" == "new" ]; then
    file=$(~/dotfiles/create_new_note.sh)
    # if exit code 1
    if [ $? -eq 1 ]; then
        echo "No note created. Exiting."
        exit 1
    fi
else
    file=$(gum file "$OBSIDIAN_VAULT")
fi

# check if ~/.shell_harpoon exists, if yes then remove it
if [ -f ~/.shell_harpoon ]; then
    rm ~/.shell_harpoon
fi

echo "$file" > ~/.shell_harpoon
