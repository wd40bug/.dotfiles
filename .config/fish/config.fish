if status is-interactive
  # Commands to run in interactive sessions can go here
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  oh-my-posh init fish --config ~/.mytheme.toml | source
  function set_poshcontext
    set -gx COLS $(tput cols)
  end


  abbr --add cl clear
  bass source /etc/profile
  pyenv init - | source
  thefuck --alias | source
end

