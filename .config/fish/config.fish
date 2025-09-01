set -gx SYSTEM $(cat ~/.system )
if status is-interactive
    if SYSTEM = "ubuntu"
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
    oh-my-posh init fish --config ~/.mytheme.toml | source
    function set_poshcontext
        set -gx COLS (tput cols)
    end


    abbr --add cl clear
    bass source /etc/profile
    pyenv virtualenv-init - | source
    direnv hook fish | source
    thefuck --alias | source

    set -g direnv_fish_mode eval_on_arrow
end
