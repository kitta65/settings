function ll
    if which exa > /dev/null
        exa -lha
    else
        ls -lha
    end
end
