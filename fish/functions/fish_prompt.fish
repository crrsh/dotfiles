function fish_prompt
    set -l last_status $status

    if not contains -- --final-rendering $argv
        set -l stat
        set -l git_info

        if test $last_status -ne 0
            set stat (set_color red)" [$last_status]"(set_color --reset)
        end

        if command -sq git
            set -l branch (git symbolic-ref --quiet --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
            if test -n "$branch"
                set -l dirty
                test -z "$(git status --porcelain=v1 --untracked-files=no 2>/dev/null)"; or set dirty "*"
                set git_info " $branch$dirty"
            end
        end

        set_color blue; echo -n (prompt_pwd)
        set_color brblack; echo -n $git_info
        echo -n $stat
        set_color --reset
        echo
    end

    set_color magenta
    echo -n "❯ "
    set_color --reset
end
