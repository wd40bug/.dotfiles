if status is-interactive
    # Commands to run in interactive sessions can go here
    oh-my-posh init fish --config ~/.mytheme.toml | source
    function set_poshcontext
        set -gx COLS (tput cols)
    end


    abbr --add cl clear
    TF_SHELL=fish thefuck --alias | source
    bass source /etc/profile
    pyenv init - | source
end
