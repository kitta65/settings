function ls
    if which exa
        exa $argv
    else
        ls $argv
    end
end
