function watcher
    if test "$argv" = "up"
        echo "running on http://localhost:8888/ "
        docker-compose -f $WATCHERPATH --project-directory (pwd) up -d
    else if test "$argv" = "down"
        docker-compose -f $WATCHERPATH --project-directory (pwd) down
    else
        echo "you have to specify 'up' or 'down'."
    end
end
