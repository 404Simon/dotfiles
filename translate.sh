options=$(gum choose "DE -> EN" "EN -> DE" "custom" "list languages")

if [ "$options" = "DE -> EN" ]; then
    prompt=$(gum input)
    ~/dotfiles/trans -b -s de -t en "$prompt"
elif [ "$options" = "EN -> DE" ]; then
    prompt=$(gum input)
    ~/dotfiles/trans -b -s en -t de "$prompt"
elif [ "$options" = "custom" ]; then
    source=$(gum input --prompt "> source language: " --placeholder "de")
    target=$(gum input --prompt "> target language: " --placeholder "en")
    prompt=$(gum input --prompt "> Translate: ")
    ~/dotfiles/trans -b -s "$source" -t "$target" "$prompt"
elif [ "$options" = "list languages" ]; then
    ~/dotfiles/trans -list-all | fzf
fi
