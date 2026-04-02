set -gx SYSTEM $(ccat ~/.system )

if test "$SYSTEM" = ubuntu
    bass source /etc/profile

    ~/.local/bin/mise activate fish | source
else
    pyenv init - | source
    pyenv virtualenv-init - | source
    direnv hook fish | source
    set -g direnv_fish_mode eval_on_arrow
end

if status is-interactive
    # oh-my-posh init fish --config ~/.mytheme.toml | source
    starship init fish | source
    function set_poshcontext
        set -gx COLS (tput cols)
    end
end
