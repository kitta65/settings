function bat
    if which docker > /dev/null
        docker run -it --rm -v (pwd):/myapp danlynn/bat $argv
    else
        echo 'installation error `docker`'
    end
end
