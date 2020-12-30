function tex2pdf
    docker container run --rm -it -v (pwd):/home/app/sync ghcr.io/dr666m1/texlive:0.0 $argv
end
