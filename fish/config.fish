if not status is-interactive
    exit 0
end

# Keybindings
fish_vi_key_bindings

# Restore emacs bindings
bind -M insert ctrl-p up-or-search
bind -M insert ctrl-n down-or-search
bind -M insert ctrl-f accept-autosuggestion
bind -M default ctrl-p up-or-search
bind -M default ctrl-n down-or-search
bind -M default ctrl-f accept-autosuggestion

# Custom bindings
bind -M insert ctrl-enter accept-autosuggestion execute
bind -M default ctrl-enter accept-autosuggestion execute
