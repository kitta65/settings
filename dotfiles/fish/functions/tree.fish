function tree
    if which exa
        exa -T $argv
    else
        echo 'installation error `exa`'
    end
end
