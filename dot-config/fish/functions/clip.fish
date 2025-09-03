function clip  --description 'stdin -> clipboard'
  if test "$SYSTEM" = "ubuntu"
    xsel -ib $argv
  else
    termux-clipboard-set $argv
  end
        
end
