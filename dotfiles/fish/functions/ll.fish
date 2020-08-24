function ll
    if which exa > /dev/null
        exa -lha $argv
    else
        ls -lha $argv
    end
end
