set -gx SYSTEM $(ccat ~/.system )
if status is-interactive
    if test "$SYSTEM" = ubuntu
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        bass source /etc/profile
    end
    oh-my-posh init fish --config ~/.mytheme.toml | source
    function set_poshcontext
        set -gx COLS (tput cols)
    end

    pyenv init - | source
    pyenv virtualenv-init - | source
    direnv hook fish | source
    thefuck --alias | source
    set -g direnv_fish_mode eval_on_arrow
end
