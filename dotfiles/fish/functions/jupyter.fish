function jupyter
    if which docker > /dev/null
        docker run -it --rm -p 8888:8888 -v (pwd):/home/jovyan/work -e JUPYTER_ENABLE_LAB=yes jupyter/scipy-notebook:17aba6048f44
    else
        echo 'installation error `docker`'
    end
end
