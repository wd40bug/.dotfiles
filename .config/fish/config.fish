if status is-interactive
    # Commands to run in interactive sessions can go here
    oh-my-posh init fish --config ~/.mytheme.toml | source
    function set_poshcontext
        set -gx COLS (tput cols)
    end


    abbr --add cl clear

    set -Ux MSYS "winsymlinks:nativestrict"
    fish_config theme choose "fish default"
end
