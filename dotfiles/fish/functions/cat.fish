function cat
    if which batcat > /dev/null
        eval (which batcat) $argv
    else if which bat > /dev/null
        eval (which bat) $argv
    else if which docker > /dev/null
        docker run -it --rm -v (pwd):/myapp danlynn/bat $argv
    else
        echo 'installation error `bat` or `docker`'
    end
end
