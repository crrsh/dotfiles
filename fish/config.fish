# Resolve symlinked ~/.config/fish back to the repo root.
set -gx DOTFILES (path dirname (path dirname (path resolve (status filename))))

status is-interactive; or return

set -g fish_greeting
set -g fish_transient_prompt 1

if type -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end

fish_add_path $HOME/.local/bin

if test (uname) = Darwin && type -q brew
    fish_add_path /opt/homebrew/bin
end

if type -q fzf
    fzf --fish | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q direnv
    # set -g direnv_fish_mode disable_arrow
    direnv hook fish | source
end

fish_vi_key_bindings
function fish_mode_prompt; end

for mode in default insert
    bind -M $mode ctrl-p up-or-search
    bind -M $mode ctrl-n down-or-search
    bind -M $mode ctrl-f accept-autosuggestion
    bind -M $mode ctrl-x,ctrl-e edit_command_buffer

    bind -M $mode ctrl-g suppress-autosuggestion

    bind -M $mode ctrl-enter accept-autosuggestion execute

    bind -M $mode ctrl-z 'fg 2>/dev/null; commandline -f repaint'

    # Avoid overwriting fzf ctrl-r if available.
    if not type -q fzf
        bind -M $mode ctrl-r history-pager
    end
end

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
abbr -a did 'docker ps -lq' # display id of latest created container
abbr -a dl 'docker logs -f'
abbr -a dll 'docker logs -f (docker ps -lq)' # follow latest container
abbr -a dps 'docker ps'
abbr -a dim 'docker images'
abbr -a drma 'docker rm (docker ps -aq)' # delete all stopped containers
abbr -a drml 'docker rm (docker ps -lq)' # delete last container
abbr -a dsa 'docker stop (docker ps -aq)' # stop all containers
abbr -a dsl 'docker stop (docker ps -lq)' # stop last container
abbr -a drmdi 'docker rmi (docker images -qf dangling=true)' # delete dangling images
abbr -a dpid 'docker inspect --format \'{{.State.Pid}}\' (docker ps -lq)'
abbr -a dcl 'docker rm (docker ps -aq); docker rmi (docker images -qf dangling=true)' # clean
abbr -a de 'docker exec -it'
abbr -a dx 'docker run --rm -it'
abbr -a db 'docker build'

# docker compose
abbr -a dc 'docker compose'
abbr -a dcu 'docker compose up'

# kubectl
abbr -a k 'kubectl'

# uv
abbr -a uvr 'uv run'
abbr -a uvs 'uv sync'
abbr -a uvl 'uv lock'

# make
abbr -a m 'make'
abbr -a mc 'make -C'

# opencode
abbr -a oc 'opencode'

# pipes
abbr -a --position anywhere L '| less'
abbr -a --position anywhere G '| rg'
for clip in pbcopy wl-copy 'xclip -selection clipboard'
    if type -q (string split ' ' -- $clip)[1]
        abbr -a --position anywhere C "| $clip"
        break
    end
end


if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher update >/dev/null
end

set -g hydro_multiline true

if set -q NVIM
    set -g _hydro_skip_git_prompt 1
    set -g $_hydro_git ""
end
