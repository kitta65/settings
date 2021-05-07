function code
  if test -n "$winuser"
    /mnt/c/Users/$winuser/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code $argv
  else
    echo 'cannot find $winuser'
  end
end
