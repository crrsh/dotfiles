# dotfiles

## fish

```bash
# delete old config
rm -rf ~/.config/fish

# or backup
mv ~/.config/fish ~/.config/fish.backup

# then symlink
ln -s $PWD ~/.config/fish

# make fish the default shell
sudo chsh -s fish $USER
```
