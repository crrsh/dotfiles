function wt
    set -l cur (git rev-parse --show-toplevel); or return
    set -l home_re '^'(string escape --style=regex $HOME)
    set -l root
    set -l p
    set -l lines
    for l in (git worktree list --porcelain)
        switch $l
            case 'worktree *'
                set p (string replace 'worktree ' '' -- $l)
                test -z "$root"; and set root $p
            case 'branch *' detached
                test "$p" = "$cur"; and continue
                set -l name
                if test "$p" = "$root"
                    set name '(root)'
                else if string match -q -- "$root/*" $p
                    set name (string replace -- "$root/" '' $p)
                else
                    set name (string replace -r -- $home_re '~' $p)
                end
                set -l br (string replace 'branch refs/heads/' '' -- $l)
                test "$l" = detached; and set br '(detached)'
                set -a lines (printf '%s\t%-36s %s%s%s' $p $name (set_color brblack) $br (set_color normal))
        end
    end
    test -z "$lines"; and echo "no other worktrees"; and return
    set -l sel (printf '%s\n' $lines | fzf --ansi --height ~40% --reverse \
        --delimiter \t --with-nth 2 --query "$argv")
    and cd (string split -f1 \t -- $sel)
end
