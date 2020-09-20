function dcl
    docker container ls $argv | grep -v 'k8s'
end
