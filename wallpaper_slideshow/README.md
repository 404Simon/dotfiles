Do not stow wallpaper_slideshow!

```bash
cd wallpaper_slideshow
stow -t ~ stowable_timer
systemctl --user daemon-reload
systemctl --user enable --now wallpaper.timer
```
