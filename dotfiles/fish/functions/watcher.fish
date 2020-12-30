function watcher
    if test "$argv" = "up"
        echo "running on http://localhost:9999/"
        docker container run -v (pwd):/work/sync -p 9999:9999 -d --name image_watcher ghcr.io/dr666m1/image_watcher
    else if test "$argv" = "down"
        docker container stop image_watcher
        docker container rm image_watcher
    else
        echo "you have to specify 'up' or 'down'."
    end
end
