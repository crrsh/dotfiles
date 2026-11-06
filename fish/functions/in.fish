function in --description "Run command in dir"
    pushd $argv[1]; or return
    $argv[2..]
    set -l s $status
    popd
    return $s
end
