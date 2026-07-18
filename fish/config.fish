status is-interactive; or exit

# Environment {{{

set -g fish_greeting

if type -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end

fish_add_path $HOME/.local/bin

if test (uname) = Darwin && type -q brew
    fish_add_path /opt/homebrew/bin
end

# }}}

# Integrations {{{

if type -q fzf
    fzf --fish | source
end

if type -q zoxide
    zoxide init fish | source
end

# }}}

# Bindings {{{

fish_vi_key_bindings

for mode in default insert
    bind -M $mode ctrl-p up-or-search
    bind -M $mode ctrl-n down-or-search
    bind -M $mode ctrl-f accept-autosuggestion

    bind -M $mode ctrl-g suppress-autosuggestion

    bind -M $mode ctrl-enter accept-autosuggestion execute

    # Avoid overwriting fzf ctrl-r if available.
    if not type -q fzf
        bind -M $mode ctrl-r history-pager
    end
end

# }}}

# Abbreviations {{{

# git
abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gaf 'git add -f'
abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gc 'git commit -v'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gcm 'git checkout main'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr -a gds 'git diff --stat'
abbr -a gs 'git status'
abbr -a gl 'git log'

# docker
abbr -a d 'docker'
abbr -a dl 'docker ps -lq' # display id of latest created container
abbr -a dim 'docker images'
abbr -a drma 'docker rm (docker ps -aq)' # delete all stopped containers
abbr -a drml 'docker rm (docker ps -lq)' # delete last container
abbr -a dsa 'docker stop (docker ps -aq)' # stop all containers
abbr -a dsl 'docker stop (docker ps -lq)' # stop last container
abbr -a drmdi 'docker rmi (docker images -qf dangling=true)' # delete dangling images
abbr -a dpid 'docker inspect --format \'{{.State.Pid}}\' (docker ps -lq)'
abbr -a dcl 'docker rm (docker ps -aq); docker rmi (docker images -qf dangling=true)' # clean
abbr -a de 'docker exec'
abbr -a db 'docker build'

# kubectl
abbr -a k 'kubectl'

# uv
abbr -a uvr 'uv run'
abbr -a uvs 'uv sync'
abbr -a uvl 'uv lock'

# make
abbr -a m 'make'
abbr -a mc 'make -C'

# }}}

# vim: foldmethod=marker foldlevel=99
