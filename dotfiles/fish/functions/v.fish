function v
    if which nvim > /dev/null
        nvim $argv
    else if which vi > /dev/null
        vim $argv
    else
        vi $argv
    end
end
