# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
term=$1
if [ ! "$#" -gt 0 ]; then
    read -p "Searchterm: " term
fi
rg --files-with-matches --no-messages -i "$term" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$term' || rg --ignore-case --pretty --context 10 '$term' {}"

