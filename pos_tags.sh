#!/bin/bash
# Stelle sicher, dass fzf installiert ist!

# Datei einlesen
entries=$(cat /Users/simon/dotfiles/tags.txt)

# Verwende fzf zur interaktiven Suche
selected=$(echo "$entries" | fzf --prompt="Suche Tag: ")

# Falls eine Auswahl getroffen wurde, zeige die Bedeutung an
if [ -n "$selected" ]; then
    # Extrahiere den Text nach dem Doppelpunkt (und führendem Leerzeichen)
    meaning="${selected#*: }"
    echo "Bedeutung: $meaning"
fi
