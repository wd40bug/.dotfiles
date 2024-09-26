if status is-interactive
  # Commands to run in interactive sessions can go here
  oh-my-posh init fish --config ~/.mytheme.toml | source
  function set_poshcontext
    set -gx COLS (tput cols)
  end


  abbr --add cl clear
  TF_SHELL=fish thefuck --alias | source

  # source "$HOME/.cargo/env.fish"
end

