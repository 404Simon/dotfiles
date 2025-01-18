open() {
  local file="$1"

  if [ -z "$file" ]; then
    echo "Usage: open <file>"
    return 1
  fi

  if [ -d "$file" ]; then
    # Open directories with Dolphin, suppress normal logs but show errors
    dolphin "$file" >/dev/null &
  elif [ "${file##*.}" = "pdf" ]; then
    # Open PDFs with Okular, suppress normal logs but show errors
    okular "$file" >/dev/null &
  elif [ "${file##*.}" = "txt" ] || [ "${file##*.}" = "md" ]; then
    # Open text files with Neovim in a new terminal window
    ghostty -e nvim "$file" >/dev/null &
  elif [ "${file##*.}" = "png" ] || [ "${file##*.}" = "jpg" ]; then
    # Open images with Feh, suppress normal logs but show errors
    feh "$file" >/dev/null &
  else
    # Fall back to xdg-open for other file types, suppress normal logs but show errors
    xdg-open "$file" >/dev/null &
  fi
}
