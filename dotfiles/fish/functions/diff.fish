function diff
    if which colordiff > /dev/null
        colordiff -u $argv
    else
        eval (which diff) -u $argv
    end
end
