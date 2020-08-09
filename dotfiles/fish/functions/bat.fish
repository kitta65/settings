function bat
    if which docker
        docker run -it --rm -v (pwd):/myapp danlynn/bat $argv
    else
        echo 'installation error `docker`'
    end
end
