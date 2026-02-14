```bash
# delete old config
rm -rf ~/.config/fish

# or backup
mv ~/.config/fish ~/.config/fish.backup

# then symlink
ln -s $PWD ~/.config/fish
```

If fish is not default user shell:

```bash
sudo chsh -s fish $USER
```
