function dots --wraps git --description "cd to dotfiles repo, or run git there"
    if not set -q argv[1]
        cd $DOTFILES
        return
    end
    git -C $DOTFILES $argv
end
