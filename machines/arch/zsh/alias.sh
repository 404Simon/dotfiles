alias jl='~/jupyter_env/.venv/bin/jupyter-lab --notebook-dir= ~/Vorlesungen/NLP/Notebooks/'
alias suspend='systemctl suspend'
alias open='xdg-open'
alias todo='vim ~/Vorlesungen/TODO.md'
alias b='bg && disown'
alias winfo='/home/simon/dev/wallpaper_slideshow/target/release/wallpaper-info'

op() {
    xdg-open "$@" >/dev/null 2>&1 &
    disown
}
compdef '_files -g "*.(pdf|PDF|epub)"' op
