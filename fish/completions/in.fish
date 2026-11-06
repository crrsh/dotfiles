complete -c in -n '__fish_is_nth_token 1' -xa '(__fish_complete_directories)'
complete -c in -n 'not __fish_is_nth_token 1' -xa '(__fish_complete_subcommand --fcs-skip=2)'
