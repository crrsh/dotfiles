if not status is-interactive
    exit 0
end

# Disable user greeting
set fish_greeting

# Defaults
if type -q nvim
    set -gx EDITOR "nvim"
    set -gx VISUAL "nvim"
end

# Add uv tools to PATH
fish_add_path $HOME/.local/bin

# Use vi bindings
fish_vi_key_bindings

# Restore emacs bindings
bind -M insert ctrl-p up-or-search
bind -M insert ctrl-n down-or-search
bind -M insert ctrl-f accept-autosuggestion
bind -M default ctrl-p up-or-search
bind -M default ctrl-n down-or-search
bind -M default ctrl-f accept-autosuggestion

# Immediately execute autosuggestions
bind -M insert ctrl-enter accept-autosuggestion execute
bind -M default ctrl-enter accept-autosuggestion execute

# Use built in history pager
bind -M insert ctrl-r history-pager
bind -M default ctrl-r history-pager

# Abbreviations
abbr -a gb 'git branch'
abbr -a gs 'git status'
abbr -a gd 'git diff'
abbr -a gds 'git diff --stat'
abbr -a gdc 'git diff --cached'
abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gch 'git checkout'
abbr -a gl 'git log'
